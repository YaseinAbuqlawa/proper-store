import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { STATS_DOC, MAX_DAILY_DAYS, MAX_MONTHLY_MONTHS, TOP_SELLING_LIMIT } from "./constants";
import {
  todayKey,
  monthKey,
  pruneMap,
  upsertTopSpenders,
  upsertTopSelling,
  validateStock,
  buildVariantStockUpdates,
  rollbackSpenderOnRefund,
} from "./helpers";
import { OrderItem, SellingEntry, SpenderEntry } from "./types";

const db = admin.firestore();
const F = admin.firestore.FieldValue;

// Valid status transitions enforced server-side.
const VALID_TRANSITIONS: Record<string, string[]> = {
  pending: ["confirmed", "cancelled"],
  confirmed: ["shipped", "cancelled"],
  shipped: ["delivered", "refunded"],
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
      const productItems = items.filter((x) => x.productId === productIds[i]);
      const totalQtyForProduct = productItems.reduce((sum, x) => sum + x.quantity, 0);
      const { variantUpdates, oosKeys, totalStockDelta } = buildVariantStockUpdates(
        productSnaps[i].data()!,
        productItems
      );
      tx.update(productRefs[i], {
        ...variantUpdates,
        outOfStockVariants: oosKeys,
        hasOutOfStockVariants: oosKeys.length > 0,
        totalStock: F.increment(totalStockDelta),
        shippedQuantity: F.increment(totalQtyForProduct),
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

export const updateOrderStatus = functions.https.onCall(async (data, context) => {
  // ── Auth: staff roles only ──────────────────────────────────────────────────
  const role = context.auth?.token?.role as string | undefined;
  if (!context.auth || !["superAdmin", "admin", "cs"].includes(role ?? "")) {
    throw new functions.https.HttpsError("permission-denied", "Insufficient role.");
  }

  const { orderId, newStatus } = data as { orderId: string; newStatus: string };

  const orderRef = db.doc(`orders/${orderId}`);
  const statsRef = db.doc(STATS_DOC);

  // ── Cancellation ─────────────────────────────────────────────────────────────
  if (newStatus === "cancelled") {
    await db.runTransaction(async (tx) => {
      // Read phase
      const orderSnap = await tx.get(orderRef);
      const statsSnap = await tx.get(statsRef);

      if (!orderSnap.exists) throw new functions.https.HttpsError("not-found", "Order not found.");
      const orderData = orderSnap.data()!;
      const oldStatus: string = orderData.status ?? "pending";

      // Validate transition (natural idempotency)
      const allowed = VALID_TRANSITIONS[oldStatus] ?? [];
      if (!allowed.includes(newStatus)) {
        throw new functions.https.HttpsError("failed-precondition", `Invalid transition: ${oldStatus} → ${newStatus}`);
      }

      const revenue: number = (orderData.netTotal ?? 0) + (orderData.shippingCost ?? 0);
      const customerId: string = orderData.customerId ?? "";
      const cancelledProducts: Array<{ productId: string; variantKey: string; quantity: number }> =
        orderData.products ?? [];

      // Use order's original date keys (not today)
      const orderDate = orderData.createdAt?.toDate?.() ?? new Date();
      const orderDayKey = orderDate.toISOString().slice(0, 10);
      const orderMonthKey = orderDate.toISOString().slice(0, 7);

      const productIds = [...new Set(cancelledProducts.map((p) => p.productId))];
      const productRefs = productIds.map((id) => db.doc(`products/${id}`));
      const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

      const statsData = statsSnap.data() ?? {};
      const newDaily = pruneMap(statsData.dailyRevenue ?? {}, orderDayKey, -revenue, MAX_DAILY_DAYS);
      const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, orderMonthKey, -revenue, MAX_MONTHLY_MONTHS);

      // Roll back topSpenders
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

      // Roll back topSelling
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

      // Restore product stock + roll back shippedQuantity
      for (let i = 0; i < productIds.length; i++) {
        if (!productSnaps[i].exists) continue;
        const productData = productSnaps[i].data()!;
        const variants: Record<string, { stockQuantity: number }> = { ...productData.variants };
        const variantUpdates: Record<string, unknown> = {};
        let totalStockDelta = 0;
        let totalQtyForProduct = 0;

        for (const item of cancelledProducts.filter((p) => p.productId === productIds[i])) {
          const v = variants[item.variantKey];
          if (!v) continue;
          const restored = v.stockQuantity + item.quantity;
          variantUpdates[`variants.${item.variantKey}.stockQuantity`] = restored;
          variants[item.variantKey] = { ...v, stockQuantity: restored };
          totalStockDelta += item.quantity;
          totalQtyForProduct += item.quantity;
        }

        const oosKeys = Object.entries(variants)
          .filter(([, v]) => v.stockQuantity <= 0)
          .map(([key]) => key);

        tx.update(productRefs[i], {
          ...variantUpdates,
          outOfStockVariants: oosKeys,
          hasOutOfStockVariants: oosKeys.length > 0,
          totalStock: F.increment(totalStockDelta),
          shippedQuantity: F.increment(-totalQtyForProduct),
        });
      }

      // Write stats + order status
      tx.set(statsRef, {
        totalRevenue: F.increment(-revenue),
        totalOrders: F.increment(-1),
        ordersByStatus: { [oldStatus]: F.increment(-1), [newStatus]: F.increment(1) },
        dailyRevenue: newDaily,
        monthlyRevenue: newMonthly,
        topSpenders: updatedSpenders,
        topSelling: updatedSelling,
        lastUpdatedAt: F.serverTimestamp(),
      }, { merge: true });

      tx.update(orderRef, { status: newStatus });
    });

    return { success: true };
  }

  // ── Refund ────────────────────────────────────────────────────────────────────
  if (newStatus === "refunded") {
    await db.runTransaction(async (tx) => {
      // Read phase
      const orderSnap = await tx.get(orderRef);
      const statsSnap = await tx.get(statsRef);

      if (!orderSnap.exists) throw new functions.https.HttpsError("not-found", "Order not found.");
      const orderData = orderSnap.data()!;
      const oldStatus: string = orderData.status ?? "pending";

      const allowed = VALID_TRANSITIONS[oldStatus] ?? [];
      if (!allowed.includes(newStatus)) {
        throw new functions.https.HttpsError("failed-precondition", `Invalid transition: ${oldStatus} → ${newStatus}`);
      }

      const revenue: number = (orderData.netTotal ?? 0) + (orderData.shippingCost ?? 0);
      const customerId: string = orderData.customerId ?? "";
      const refundedProducts: Array<{ productId: string; variantKey: string; quantity: number }> =
        orderData.products ?? [];

      const productIds = [...new Set(refundedProducts.map((p) => p.productId))];
      const productRefs = productIds.map((id) => db.doc(`products/${id}`));
      const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

      const statsData = statsSnap.data() ?? {};
      const customerRef = db.doc(`customers/${customerId}`);

      // Use order's original date keys for the refund maps
      const orderDate = orderData.createdAt?.toDate?.() ?? new Date();
      const orderDayKey = orderDate.toISOString().slice(0, 10);
      const orderMonthKey = orderDate.toISOString().slice(0, 7);

      // Parallel refund revenue maps (additive — never subtract from revenue maps)
      const newDailyRefunded = pruneMap(statsData.dailyRefunded ?? {}, orderDayKey, revenue, MAX_DAILY_DAYS);
      const newMonthlyRefunded = pruneMap(statsData.monthlyRefunded ?? {}, orderMonthKey, revenue, MAX_MONTHLY_MONTHS);

      // Roll back topSpenders totalSpent + increment refundCount
      const updatedSpenders = rollbackSpenderOnRefund(statsData.topSpenders ?? [], customerId, revenue);

      // Update topSelling — increment totalRefunded per item, re-sort by actualSold (totalSold - totalRefunded)
      const existingSelling: SellingEntry[] = statsData.topSelling ?? [];
      const updatedSelling = existingSelling
        .map((s) => {
          const match = refundedProducts.find(
            (p) => `${p.productId}_${p.variantKey}` === s.id
          );
          if (!match) return s;
          return { ...s, totalRefunded: (s.totalRefunded ?? 0) + match.quantity };
        })
        .sort((a, b) => {
          const actualA = a.totalSold - (a.totalRefunded ?? 0);
          const actualB = b.totalSold - (b.totalRefunded ?? 0);
          return actualB - actualA;
        })
        .slice(0, TOP_SELLING_LIMIT);

      // Restore product stock + increment refundedQuantity + decrement shippedQuantity
      for (let i = 0; i < productIds.length; i++) {
        if (!productSnaps[i].exists) continue;
        const productData = productSnaps[i].data()!;
        const variants: Record<string, { stockQuantity: number }> = { ...productData.variants };
        const variantUpdates: Record<string, unknown> = {};
        let totalStockDelta = 0;
        let totalQtyForProduct = 0;

        for (const item of refundedProducts.filter((p) => p.productId === productIds[i])) {
          const v = variants[item.variantKey];
          if (!v) continue;
          const restored = v.stockQuantity + item.quantity;
          variantUpdates[`variants.${item.variantKey}.stockQuantity`] = restored;
          variants[item.variantKey] = { ...v, stockQuantity: restored };
          totalStockDelta += item.quantity;
          totalQtyForProduct += item.quantity;
        }

        const oosKeys = Object.entries(variants)
          .filter(([, v]) => v.stockQuantity <= 0)
          .map(([key]) => key);

        tx.update(productRefs[i], {
          ...variantUpdates,
          outOfStockVariants: oosKeys,
          hasOutOfStockVariants: oosKeys.length > 0,
          totalStock: F.increment(totalStockDelta),
          refundedQuantity: F.increment(totalQtyForProduct),
        });
      }

      // Writes: customer refundCount, stats, order status
      tx.set(customerRef, { refundCount: F.increment(1) }, { merge: true });

      tx.set(statsRef, {
        totalRefunded: F.increment(revenue),
        refundedOrders: F.increment(1),
        ordersByStatus: { [oldStatus]: F.increment(-1), [newStatus]: F.increment(1) },
        dailyRefunded: newDailyRefunded,
        monthlyRefunded: newMonthlyRefunded,
        topSpenders: updatedSpenders,
        topSelling: updatedSelling,
        lastUpdatedAt: F.serverTimestamp(),
      }, { merge: true });

      tx.update(orderRef, { status: newStatus });
    });

    return { success: true };
  }

  // ── Other valid transitions (confirmed, shipped, delivered) ───────────────────
  await db.runTransaction(async (tx) => {
    const orderSnap = await tx.get(orderRef);

    if (!orderSnap.exists) throw new functions.https.HttpsError("not-found", "Order not found.");
    const oldStatus: string = orderSnap.data()!.status ?? "pending";

    const allowed = VALID_TRANSITIONS[oldStatus] ?? [];
    if (!allowed.includes(newStatus)) {
      throw new functions.https.HttpsError("failed-precondition", `Invalid transition: ${oldStatus} → ${newStatus}`);
    }

    tx.set(statsRef, {
      ordersByStatus: { [oldStatus]: F.increment(-1), [newStatus]: F.increment(1) },
      lastUpdatedAt: F.serverTimestamp(),
    }, { merge: true });

    tx.update(orderRef, { status: newStatus });
  });

  return { success: true };
});
