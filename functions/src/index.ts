import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

admin.initializeApp();

const db = admin.firestore();
const auth = admin.auth();
const F = admin.firestore.FieldValue;

// ─── Constants ───────────────────────────────────────────────────────────────

const VALID_ROLES = ["superAdmin", "admin", "cs"] as const;
type StaffRole = (typeof VALID_ROLES)[number];

const STATS_DOC = "stats/dashboard";
const MAX_DAILY_DAYS = 90;
const MAX_MONTHLY_MONTHS = 24;
const TOP_SPENDERS_LIMIT = 10;
const TOP_SELLING_LIMIT = 10;

// ─── Types ────────────────────────────────────────────────────────────────────

interface OrderItem {
  productId: string;
  variantKey: string;
  quantity: number;
  sellingPrice: number;
  discountValue: number;
  imageUrl: string;
  name: string;
}

interface SpenderEntry {
  customerId: string;
  name: string;
  totalSpent: number;
  orderCount: number;
}

interface SellingEntry {
  id: string;
  productName: string;
  variantKey: string;
  variantName: string;
  imageUrl: string;
  totalSold: number;
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

function assertSuperAdmin(context: functions.https.CallableContext): void {
  if (context.auth?.token?.role !== "superAdmin") {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only superAdmin can perform this action."
    );
  }
}

function todayKey(): string {
  return new Date().toISOString().slice(0, 10); // YYYY-MM-DD
}

function monthKey(): string {
  return new Date().toISOString().slice(0, 7); // YYYY-MM
}

/**
 * Removes oldest entries from a date-keyed map to keep it within maxEntries.
 * Never allows negative values — floors each value at 0.
 */
function pruneMap(
  existing: Record<string, number>,
  key: string,
  delta: number,
  maxEntries: number
): Record<string, number> {
  const updated: Record<string, number> = { ...existing };
  updated[key] = Math.max(0, (updated[key] ?? 0) + delta);

  const keys = Object.keys(updated).sort();
  while (keys.length > maxEntries) {
    const oldest = keys.shift()!;
    delete updated[oldest];
  }

  return updated;
}

/**
 * Recalculates the outOfStockVariants array from a variants map.
 * A variant is OOS when stockQuantity <= 0.
 */
function recalcVariantOos(
  variants: Record<string, { stockQuantity: number }>
): string[] {
  return Object.entries(variants)
    .filter(([, v]) => v.stockQuantity <= 0)
    .map(([key]) => key);
}

/**
 * Upserts a customer into the top spenders list and returns the sorted top N.
 */
function upsertTopSpenders(
  existing: SpenderEntry[],
  customerId: string,
  customerName: string,
  revenue: number
): SpenderEntry[] {
  const updated = [...existing];
  const idx = updated.findIndex((s) => s.customerId === customerId);
  if (idx >= 0) {
    updated[idx] = {
      ...updated[idx],
      totalSpent: updated[idx].totalSpent + revenue,
      orderCount: (updated[idx].orderCount ?? 0) + 1,
    };
  } else {
    updated.push({ customerId, name: customerName, totalSpent: revenue, orderCount: 1 });
  }
  return updated.sort((a, b) => b.totalSpent - a.totalSpent).slice(0, TOP_SPENDERS_LIMIT);
}

/**
 * Validates stock for all items against their product snapshots.
 * Throws HttpsError if any item is out of stock or the product is missing.
 */
function validateStock(
  items: OrderItem[],
  productIds: string[],
  productSnaps: admin.firestore.DocumentSnapshot[]
): void {
  for (const item of items) {
    const snap = productSnaps[productIds.indexOf(item.productId)];
    if (!snap.exists) {
      throw new functions.https.HttpsError("not-found", "product_not_found");
    }
    const variants: Record<string, { stockQuantity: number }> =
      snap.data()!.variants ?? {};
    const variant = variants[item.variantKey];
    if (!variant || variant.stockQuantity < item.quantity) {
      const productData = snap.data()!;
      const variantData = (productData.variants ?? {})[item.variantKey] as
        | { name?: string }
        | undefined;
      throw new functions.https.HttpsError(
        "failed-precondition",
        "out_of_stock",
        {
          productName: productData.name ?? "",
          variantName: variantData?.name ?? "",
          available: variant?.stockQuantity ?? 0,
        }
      );
    }
  }
}

/**
 * Builds the top selling list by upserting each ordered item (with full variant details).
 */
function upsertTopSelling(
  existing: SellingEntry[],
  items: OrderItem[],
  productIds: string[],
  productSnaps: admin.firestore.DocumentSnapshot[]
): SellingEntry[] {
  const updated = [...existing];
  for (const item of items) {
    const entryId = `${item.productId}_${item.variantKey}`;
    const productData = productSnaps[productIds.indexOf(item.productId)].data()!;
    const variants: Record<string, { name: string; imageUrls?: string[] }> =
      productData.variants ?? {};
    const variant = variants[item.variantKey] ?? {};

    const idx = updated.findIndex((p) => p.id === entryId);
    if (idx >= 0) {
      updated[idx] = { ...updated[idx], totalSold: updated[idx].totalSold + item.quantity };
    } else {
      updated.push({
        id: entryId,
        productName: productData.name ?? "",
        variantKey: item.variantKey,
        variantName: variant.name ?? "",
        imageUrl: variant.imageUrls?.[0] ?? productData.mainImageUrl ?? "",
        totalSold: item.quantity,
      });
    }
  }
  return updated.sort((a, b) => b.totalSold - a.totalSold).slice(0, TOP_SELLING_LIMIT);
}

/**
 * Builds the Firestore variant stock update map for a single product,
 * decrementing stock for each ordered item.
 * Returns the dot-notation update map, recalculated OOS keys, and total stock delta.
 */
function buildVariantStockUpdates(
  productData: admin.firestore.DocumentData,
  itemsForProduct: OrderItem[]
): {
  variantUpdates: Record<string, unknown>;
  oosKeys: string[];
  totalStockDelta: number;
} {
  const variants: Record<string, { stockQuantity: number }> = {
    ...productData.variants,
  };
  let totalStockDelta = 0;
  const variantUpdates: Record<string, unknown> = {};

  for (const item of itemsForProduct) {
    const v = variants[item.variantKey];
    const newQty = Math.max(0, v.stockQuantity - item.quantity);
    totalStockDelta -= v.stockQuantity - newQty;
    variantUpdates[`variants.${item.variantKey}.stockQuantity`] = newQty;
    variants[item.variantKey] = { ...v, stockQuantity: newQty };
  }

  return { variantUpdates, oosKeys: recalcVariantOos(variants), totalStockDelta };
}

// ─── Staff Callables ──────────────────────────────────────────────────────────

export const createStaffAccount = functions.https.onCall(
  async (data, context) => {
    assertSuperAdmin(context);

    const { username, password, role } = data as {
      username: string;
      password: string;
      role: StaffRole;
    };

    if (!username || typeof username !== "string" || username.trim() === "") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "username is required."
      );
    }
    if (!password || password.length < 6) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "password must be at least 6 characters."
      );
    }
    if (!VALID_ROLES.includes(role)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `role must be one of: ${VALID_ROLES.join(", ")}.`
      );
    }

    const email = `${username.trim()}@properstaff.com`;

    const userRecord = await auth.createUser({ email, password });
    await auth.setCustomUserClaims(userRecord.uid, { role });

    await db.doc(`staff/${userRecord.uid}`).set({
      uid: userRecord.uid,
      username: username.trim(),
      role,
      createdAt: F.serverTimestamp(),
    });

    return { uid: userRecord.uid };
  }
);

export const changeStaffRole = functions.https.onCall(
  async (data, context) => {
    assertSuperAdmin(context);

    const { uid, role } = data as { uid: string; role: StaffRole };

    if (!uid) {
      throw new functions.https.HttpsError("invalid-argument", "uid is required.");
    }
    if (!VALID_ROLES.includes(role)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `role must be one of: ${VALID_ROLES.join(", ")}.`
      );
    }

    await auth.setCustomUserClaims(uid, { role });
    await db.doc(`staff/${uid}`).update({ role });

    return { success: true };
  }
);

export const changeStaffPassword = functions.https.onCall(
  async (data, context) => {
    assertSuperAdmin(context);

    const { uid, newPassword } = data as { uid: string; newPassword: string };

    if (!uid) {
      throw new functions.https.HttpsError("invalid-argument", "uid is required.");
    }
    if (!newPassword || newPassword.length < 6) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "newPassword must be at least 6 characters."
      );
    }

    await auth.updateUser(uid, { password: newPassword });

    return { success: true };
  }
);

export const deleteStaffAccount = functions.https.onCall(
  async (data, context) => {
    assertSuperAdmin(context);

    const { uid } = data as { uid: string };

    if (!uid) {
      throw new functions.https.HttpsError("invalid-argument", "uid is required.");
    }

    await auth.deleteUser(uid);
    await db.doc(`staff/${uid}`).delete();

    return { success: true };
  }
);

// ─── Order Callable ───────────────────────────────────────────────────────────

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
    // ── Read phase ────────────────────────────────────────────────────────────
    const statsSnap = await tx.get(statsRef);
    const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

    // ── Validate stock ────────────────────────────────────────────────────────
    validateStock(items, productIds, productSnaps);

    // ── Stats ─────────────────────────────────────────────────────────────────
    const statsData = statsSnap.data() ?? {};
    const revenue = netTotal + shippingCost;

    const newDaily = pruneMap(statsData.dailyRevenue ?? {}, todayKey(), revenue, MAX_DAILY_DAYS);
    const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, monthKey(), revenue, MAX_MONTHLY_MONTHS);
    const topSpenders = upsertTopSpenders(statsData.topSpenders ?? [], customerId, customerName, revenue);
    const topSelling = upsertTopSelling(statsData.topSelling ?? [], items, productIds, productSnaps);

    // ── Write order ───────────────────────────────────────────────────────────
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

    // ── Update product stock ──────────────────────────────────────────────────
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

    // ── Update stats ──────────────────────────────────────────────────────────
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

// ─── Firestore Triggers ───────────────────────────────────────────────────────

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
      // ── Read phase ──────────────────────────────────────────────────────────
      const statsSnap = await tx.get(statsRef);
      const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

      const statsData = statsSnap.data() ?? {};
      const revenue: number = (order.netTotal ?? 0) + (order.shippingCost ?? 0);
      const customerId: string = order.customerId ?? "";
      const customerName: string = order.customerName ?? "";

      const newDaily = pruneMap(statsData.dailyRevenue ?? {}, todayKey(), revenue, MAX_DAILY_DAYS);
      const newMonthly = pruneMap(statsData.monthlyRevenue ?? {}, monthKey(), revenue, MAX_MONTHLY_MONTHS);
      const topSpenders = upsertTopSpenders(statsData.topSpenders ?? [], customerId, customerName, revenue);

      // Top selling — use the same shape as createOrder callable
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

      // ── Write phase ─────────────────────────────────────────────────────────
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
    const revenue: number =
      (before.netTotal ?? 0) + (before.shippingCost ?? 0);
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

      // ── Roll back topSpenders ────────────────────────────────────────────
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
        .slice(0, TOP_SPENDERS_LIMIT);

      // ── Roll back topSelling ─────────────────────────────────────────────
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
        .slice(0, TOP_SELLING_LIMIT);

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

export const onUserCreated = functions.firestore
  .document("customers/{uid}")
  .onCreate(async () => {
    await db.doc(STATS_DOC).set(
      {
        totalCustomers: F.increment(1),
        lastUpdatedAt: F.serverTimestamp(),
      },
      { merge: true }
    );
  });

export const onProductUpdated = functions.firestore
  .document("products/{productId}")
  .onUpdate(async (change) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.hasOutOfStockVariants === after.hasOutOfStockVariants) return;

    const delta = after.hasOutOfStockVariants ? 1 : -1;

    await db.doc(STATS_DOC).set(
      {
        outOfStockCount: F.increment(delta),
        lastUpdatedAt: F.serverTimestamp(),
      },
      { merge: true }
    );
  });
