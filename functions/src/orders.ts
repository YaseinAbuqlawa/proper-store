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
} from "./helpers";
import { OrderItem, SellingEntry, SpenderEntry } from "./types";

const db = admin.firestore();
const F = admin.firestore.FieldValue;

/**
 * Atomically validates stock, writes the order, decrements variant stock,
 * and updates dashboard stats — all in a single Firestore transaction.
 *
 * Revenue = netTotal + shippingCost (grand total the customer pays).
 */
export const createOrder = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be authenticated to place an order."
    );
  }

  const {
    orderId,
    customerId,
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
    customerId: string;
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
    tx.set(db.doc(`orders/${orderId}`), {
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

export const onOrderCreated = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snap) => {
    // Orders created via the createOrder callable already have stockProcessed:true
    // and stats updated atomically. Nothing to do for them.
    if (snap.data()?.stockProcessed === true) return null;

    const order = snap.data();
    const statsRef = db.doc(STATS_DOC);

    const items: Array<{
      productId: string;
      variantKey: string;
      quantity: number;
      price: number;
    }> = order.items ?? [];

    const productIds = [...new Set(items.map((i) => i.productId))];
    const productRefs = productIds.map((id) => db.doc(`products/${id}`));

    await db.runTransaction(async (tx) => {
      // ── Read phase ────────────────────────────────────────────────────────
      const statsSnap = await tx.get(statsRef);
      const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

      const statsData = statsSnap.data() ?? {};
      const revenue: number = (order.netTotal ?? 0) + (order.shippingCost ?? 0);
      const customerId: string = order.customerId ?? "";
      const customerName: string = order.customerName ?? "";

      const newDaily = pruneMap(statsData.dailyRevenue ?? {}, todayKey(), revenue, MAX_DAILY_DAYS);
      const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, monthKey(), revenue, MAX_MONTHLY_MONTHS);
      const topSpenders = upsertTopSpenders(statsData.topSpenders ?? [], customerId, customerName, revenue);

      const orderItems: OrderItem[] = items.map((x) => ({
        ...x,
        sellingPrice: x.price ?? 0,
        discountValue: 0,
        imageUrl: "",
        name: "",
      }));
      const topSelling = upsertTopSelling(
        statsData.topSelling ?? [],
        orderItems,
        productIds,
        productSnaps
      );

      // ── Write phase ───────────────────────────────────────────────────────
      tx.set(
        statsRef,
        {
          totalRevenue: F.increment(revenue),
          totalOrders: F.increment(1),
          ordersByStatus: { [order.status ?? "pending"]: F.increment(1) },
          dailyRevenue: newDaily,
          monthlyRevenue: newMonthly,
          topSpenders,
          topSelling,
          lastUpdatedAt: F.serverTimestamp(),
        },
        { merge: true }
      );

      for (let i = 0; i < productIds.length; i++) {
        if (!productSnaps[i].exists) continue;
        const { variantUpdates, oosKeys, totalStockDelta } = buildVariantStockUpdates(
          productSnaps[i].data()!,
          items
            .filter((x) => x.productId === productIds[i])
            .map((x) => ({ ...x, sellingPrice: 0, discountValue: 0, imageUrl: "", name: "" }))
        );
        tx.update(productRefs[i], {
          ...variantUpdates,
          outOfStockVariants: oosKeys,
          hasOutOfStockVariants: oosKeys.length > 0,
          totalStock: F.increment(totalStockDelta),
        });
      }
    });
    return null;
  });

export const onOrderUpdated = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.status === after.status) return;

    const statsRef = db.doc(STATS_DOC);
    const oldStatus: string = before.status ?? "pending";
    const newStatus: string = after.status ?? "pending";

    if (newStatus !== "cancelled") {
      // Simple status swap — no transaction needed for just incrementing counts
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
      return;
    }

    // Cancellation: deduct revenue, roll back topSpenders & topSelling.
    // Stock restore is handled atomically by the admin client's transaction.
    const revenue: number = (before.netTotal ?? 0) + (before.shippingCost ?? 0);
    const customerId: string = before.customerId ?? "";
    const cancelledProducts: Array<{
      productId: string;
      variantKey: string;
      quantity: number;
    }> = before.products ?? [];

    await db.runTransaction(async (tx) => {
      const statsSnap = await tx.get(statsRef);
      const statsData = statsSnap.data() ?? {};

      const newDaily = pruneMap(statsData.dailyRevenue ?? {}, todayKey(), -revenue, MAX_DAILY_DAYS);
      const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, monthKey(), -revenue, MAX_MONTHLY_MONTHS);

      // ── Roll back topSpenders ──────────────────────────────────────────────
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

      // ── Roll back topSelling ───────────────────────────────────────────────
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
  });
