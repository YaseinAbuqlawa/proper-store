import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { STATS_DOC, MAX_DAILY_DAYS, MAX_MONTHLY_MONTHS } from "./constants";
import {
  todayKey,
  monthKey,
  pruneMap,
  upsertTopSpenders,
  upsertTopSelling,
  validateStock,
  buildVariantStockUpdates,
  incrementSpenderRefundCount,
} from "./helpers";
import { OrderItem, SellingEntry, SpenderEntry } from "./types";

const db = admin.firestore();
const F = admin.firestore.FieldValue;

// Valid status transitions enforced server-side.
const VALID_TRANSITIONS: Record<string, string[]> = {
  pending: ["confirmed", "cancelled"],
  confirmed: ["shipped", "cancelled"],
  shipped: ["delivered"],
  delivered: ["refunded"],
};

/**
 * Atomically validates stock, writes the order, decrements variant stock,
 * and updates dashboard stats — all in a single Firestore transaction.
 *
 * Rate-limited: max 5 orders per customer per hour.
 * Identity comes from context.auth.uid — never trusted from the client payload.
 */
export const createOrder = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be authenticated to place an order."
    );
  }

  const customerId = context.auth.uid;

  // ── Rate limit: max 5 orders per customer per hour ──────────────────────────
  const oneHourAgo = Date.now() - 60 * 60 * 1000;
  const recentOrdersSnap = await db
    .collection("orders")
    .where("customerId", "==", customerId)
    .where("createdAt", ">=", new Date(oneHourAgo))
    .get();

  if (recentOrdersSnap.size >= 5) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Too many orders placed in a short time. Please wait before placing another."
    );
  }

  const {
    orderId,
    customerName,
    items,
    totalPrice,
    discountTotal,
    netTotal,
    shippingCost,
    shippingAddress,
    paymentMethod,
  } = data as {
    orderId: string;
    customerName: string;
    items: OrderItem[];
    totalPrice: number;
    discountTotal: number;
    netTotal: number;
    shippingCost: number;
    shippingAddress: Record<string, unknown>;
    paymentMethod: string;
  };

  const statsRef = db.doc(STATS_DOC);
  const productIds = [...new Set(items.map((i) => i.productId))];
  const productRefs = productIds.map((id) => db.doc(`products/${id}`));

  await db.runTransaction(async (tx) => {
    // ── Read phase ──────────────────────────────────────────────────────────
    const statsSnap = await tx.get(statsRef);
    const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

    // ── Validate stock ──────────────────────────────────────────────────────
    validateStock(items, productIds, productSnaps);

    // ── Stats ───────────────────────────────────────────────────────────────
    const statsData = statsSnap.data() ?? {};
    const revenue = netTotal + shippingCost;

    const newDaily = pruneMap(statsData.dailyRevenue ?? {}, todayKey(), revenue, MAX_DAILY_DAYS);
    const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, monthKey(), revenue, MAX_MONTHLY_MONTHS);
    const topSpenders = upsertTopSpenders(statsData.topSpenders ?? [], customerId, customerName, revenue);
    const topSelling = upsertTopSelling(statsData.topSelling ?? [], items, productIds, productSnaps);

    // ── Write order ─────────────────────────────────────────────────────────
    tx.create(db.doc(`orders/${orderId}`), {
      customerId,
      products: items.map((i) => ({
        productId: i.productId,
        variantKey: i.variantKey,
        name: i.name,
        imageUrl: i.imageUrl,
        sellingPrice: i.sellingPrice,
        discountValue: i.discountValue,
        quantity: i.quantity,
      })),
      totalPrice,
      discountTotal,
      netTotal,
      shippingCost,
      shippingAddress,
      paymentMethod,
      status: "pending",
      createdAt: F.serverTimestamp(),
      stockProcessed: true,
    });

    // ── Update product stock ────────────────────────────────────────────────
    for (let i = 0; i < productIds.length; i++) {
      const { variantUpdates, oosKeys, totalStockDelta } = buildVariantStockUpdates(
        productSnaps[i].data()!,
        items.filter((x) => x.productId === productIds[i])
      );
      tx.update(productRefs[i], {
        ...variantUpdates,
        outOfStockVariants: oosKeys,
        hasOutOfStockVariants: oosKeys.length > 0,
        totalStock: F.increment(totalStockDelta),
      });
    }

    // ── Update stats ────────────────────────────────────────────────────────
    tx.set(
      statsRef,
      {
        totalRevenue: F.increment(revenue),
        totalOrders: F.increment(1),
        ordersByStatus: { pending: F.increment(1) },
        dailyRevenue: newDaily,
        monthlyRevenue: newMonthly,
        topSpenders,
        topSelling,
        lastUpdatedAt: F.serverTimestamp(),
      },
      { merge: true }
    );
  });

  return { orderId };
});

export const onOrderUpdated = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.status === after.status) return;

    const oldStatus: string = before.status ?? "pending";
    const newStatus: string = after.status ?? "pending";

    // ── Enforce state machine ────────────────────────────────────────────────
    const allowed = VALID_TRANSITIONS[oldStatus] ?? [];
    if (!allowed.includes(newStatus)) return;

    const statsRef = db.doc(STATS_DOC);

    // ── Cancellation ─────────────────────────────────────────────────────────
    if (newStatus === "cancelled") {
      const revenue: number = (before.netTotal ?? 0) + (before.shippingCost ?? 0);
      const customerId: string = before.customerId ?? "";
      const cancelledProducts: Array<{
        productId: string;
        variantKey: string;
        quantity: number;
      }> = before.products ?? [];

      // Use the order's original date keys — not today's date.
      const orderDate = before.createdAt?.toDate?.() ?? new Date();
      const orderDayKey = orderDate.toISOString().slice(0, 10);
      const orderMonthKey = orderDate.toISOString().slice(0, 7);

      const productIds = [...new Set(cancelledProducts.map((p) => p.productId))];
      const productRefs = productIds.map((id) => db.doc(`products/${id}`));

      await db.runTransaction(async (tx) => {
        const statsSnap = await tx.get(statsRef);
        const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));
        const statsData = statsSnap.data() ?? {};

        const newDaily = pruneMap(statsData.dailyRevenue ?? {}, orderDayKey, -revenue, MAX_DAILY_DAYS);
        const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, orderMonthKey, -revenue, MAX_MONTHLY_MONTHS);

        // ── Roll back topSpenders ───────────────────────────────────────────
        const existingSpenders: SpenderEntry[] = statsData.topSpenders ?? [];
        const updatedSpenders = existingSpenders
          .map((s) => {
            if (s.customerId !== customerId) return s;
            return {
              ...s,
              totalSpent: Math.max(0, s.totalSpent - revenue),
              orderCount: Math.max(0, (s.orderCount ?? 0) - 1),
            };
          })
          .filter((s) => s.orderCount > 0)
          .sort((a, b) => b.totalSpent - a.totalSpent)
          .slice(0, 10);

        // ── Roll back topSelling ────────────────────────────────────────────
        const existingSelling: SellingEntry[] = statsData.topSelling ?? [];
        const sellingCopy = [...existingSelling];
        for (const item of cancelledProducts) {
          const entryId = `${item.productId}_${item.variantKey}`;
          const idx = sellingCopy.findIndex((p) => p.id === entryId);
          if (idx >= 0) {
            sellingCopy[idx] = {
              ...sellingCopy[idx],
              totalSold: Math.max(0, sellingCopy[idx].totalSold - item.quantity),
            };
          }
        }
        const updatedSelling = sellingCopy
          .filter((p) => p.totalSold > 0)
          .sort((a, b) => b.totalSold - a.totalSold)
          .slice(0, 10);

        // ── Restore product stock ───────────────────────────────────────────
        for (let i = 0; i < productIds.length; i++) {
          if (!productSnaps[i].exists) continue;
          const productData = productSnaps[i].data()!;
          const variants: Record<string, { stockQuantity: number }> = {
            ...productData.variants,
          };
          const variantUpdates: Record<string, unknown> = {};
          let totalStockDelta = 0;

          for (const item of cancelledProducts.filter((p) => p.productId === productIds[i])) {
            const v = variants[item.variantKey];
            if (!v) continue;
            const restored = v.stockQuantity + item.quantity;
            variantUpdates[`variants.${item.variantKey}.stockQuantity`] = restored;
            variants[item.variantKey] = { ...v, stockQuantity: restored };
            totalStockDelta += item.quantity;
          }

          const oosKeys = Object.entries(variants)
            .filter(([, v]) => v.stockQuantity <= 0)
            .map(([key]) => key);

          tx.update(productRefs[i], {
            ...variantUpdates,
            outOfStockVariants: oosKeys,
            hasOutOfStockVariants: oosKeys.length > 0,
            totalStock: F.increment(totalStockDelta),
          });
        }

        tx.set(
          statsRef,
          {
            totalRevenue: F.increment(-revenue),
            totalOrders: F.increment(-1),
            ordersByStatus: {
              [oldStatus]: F.increment(-1),
              [newStatus]: F.increment(1),
            },
            dailyRevenue: newDaily,
            monthlyRevenue: newMonthly,
            topSpenders: updatedSpenders,
            topSelling: updatedSelling,
            lastUpdatedAt: F.serverTimestamp(),
          },
          { merge: true }
        );
      });
      return;
    }

    // ── Refund ───────────────────────────────────────────────────────────────
    if (newStatus === "refunded") {
      const revenue: number = (before.netTotal ?? 0) + (before.shippingCost ?? 0);
      const customerId: string = before.customerId ?? "";
      const refundedProducts: Array<{
        productId: string;
        variantKey: string;
        quantity: number;
      }> = before.products ?? [];

      const productIds = [...new Set(refundedProducts.map((p) => p.productId))];
      const productRefs = productIds.map((id) => db.doc(`products/${id}`));
      const customerRef = db.doc(`customers/${customerId}`);

      await db.runTransaction(async (tx) => {
        const statsSnap = await tx.get(statsRef);
        const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));
        const statsData = statsSnap.data() ?? {};

        // ── Update topSpenders refundCount ─────────────────────────────────
        const updatedSpenders = incrementSpenderRefundCount(
          statsData.topSpenders ?? [],
          customerId
        );

        // ── Restore product stock ──────────────────────────────────────────
        for (let i = 0; i < productIds.length; i++) {
          if (!productSnaps[i].exists) continue;
          const productData = productSnaps[i].data()!;
          const variants: Record<string, { stockQuantity: number }> = {
            ...productData.variants,
          };
          const variantUpdates: Record<string, unknown> = {};
          let totalStockDelta = 0;

          for (const item of refundedProducts.filter((p) => p.productId === productIds[i])) {
            const v = variants[item.variantKey];
            if (!v) continue;
            const restored = v.stockQuantity + item.quantity;
            variantUpdates[`variants.${item.variantKey}.stockQuantity`] = restored;
            variants[item.variantKey] = { ...v, stockQuantity: restored };
            totalStockDelta += item.quantity;
          }

          const oosKeys = Object.entries(variants)
            .filter(([, v]) => v.stockQuantity <= 0)
            .map(([key]) => key);

          tx.update(productRefs[i], {
            ...variantUpdates,
            outOfStockVariants: oosKeys,
            hasOutOfStockVariants: oosKeys.length > 0,
            totalStock: F.increment(totalStockDelta),
          });
        }

        // ── Update customer refundCount ─────────────────────────────────────
        tx.set(
          customerRef,
          { refundCount: F.increment(1) },
          { merge: true }
        );

        tx.set(
          statsRef,
          {
            totalRefunded: F.increment(revenue),
            refundedOrders: F.increment(1),
            ordersByStatus: {
              [oldStatus]: F.increment(-1),
              [newStatus]: F.increment(1),
            },
            topSpenders: updatedSpenders,
            lastUpdatedAt: F.serverTimestamp(),
          },
          { merge: true }
        );
      });
      return;
    }

    // ── Other valid transitions: swap ordersByStatus counters only ────────────
    await statsRef.set(
      {
        ordersByStatus: {
          [oldStatus]: F.increment(-1),
          [newStatus]: F.increment(1),
        },
        lastUpdatedAt: F.serverTimestamp(),
      },
      { merge: true }
    );
  });
