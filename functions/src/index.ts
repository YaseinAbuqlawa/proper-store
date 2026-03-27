import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

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

// ─── Firestore Triggers ───────────────────────────────────────────────────────

export const onOrderCreated = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snap) => {
    const order = snap.data();
    const statsRef = db.doc(STATS_DOC);

    // Collect unique product IDs from order items
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
      const existingDaily: Record<string, number> = statsData.dailyRevenue ?? {};
      const existingMonthly: Record<string, number> =
        statsData.monthlyRevenue ?? {};

      const revenue: number = order.totalAmount ?? 0;
      const customerId: string = order.customerId ?? "";
      const customerName: string = order.customerName ?? "";

      // Top spenders
      const existingSpenders: Array<{
        customerId: string;
        name: string;
        totalSpent: number;
      }> = statsData.topSpenders ?? [];
      const spenderIndex = existingSpenders.findIndex(
        (s) => s.customerId === customerId
      );
      const updatedSpenders = [...existingSpenders];
      if (spenderIndex >= 0) {
        updatedSpenders[spenderIndex] = {
          ...updatedSpenders[spenderIndex],
          totalSpent: updatedSpenders[spenderIndex].totalSpent + revenue,
        };
      } else {
        updatedSpenders.push({ customerId, name: customerName, totalSpent: revenue });
      }
      const topSpenders = updatedSpenders
        .sort((a, b) => b.totalSpent - a.totalSpent)
        .slice(0, TOP_SPENDERS_LIMIT);

      // Top selling products
      const existingSelling: Array<{
        productId: string;
        name: string;
        totalSold: number;
      }> = statsData.topSelling ?? [];
      const updatedSelling = [...existingSelling];
      for (const item of items) {
        const idx = updatedSelling.findIndex(
          (p) => p.productId === item.productId
        );
        if (idx >= 0) {
          updatedSelling[idx] = {
            ...updatedSelling[idx],
            totalSold: updatedSelling[idx].totalSold + item.quantity,
          };
        } else {
          updatedSelling.push({
            productId: item.productId,
            name: item.productId, // will be updated if product doc has name
            totalSold: item.quantity,
          });
        }
      }
      const topSelling = updatedSelling
        .sort((a, b) => b.totalSold - a.totalSold)
        .slice(0, TOP_SELLING_LIMIT);

      // Revenue maps
      const newDaily = pruneMap(
        existingDaily,
        todayKey(),
        revenue,
        MAX_DAILY_DAYS
      );
      const newMonthly = pruneMap(
        existingMonthly,
        monthKey(),
        revenue,
        MAX_MONTHLY_MONTHS
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

      // Update product stock
      for (let i = 0; i < productIds.length; i++) {
        const productId = productIds[i];
        const productSnap = productSnaps[i];
        if (!productSnap.exists) continue;

        const productData = productSnap.data()!;
        const variants: Record<string, { stockQuantity: number }> =
          productData.variants ?? {};

        let totalStockDelta = 0;
        const updatedVariants = { ...variants };

        for (const item of items.filter((x) => x.productId === productId)) {
          const v = updatedVariants[item.variantKey];
          if (v) {
            const newQty = Math.max(0, v.stockQuantity - item.quantity);
            totalStockDelta -= v.stockQuantity - newQty;
            updatedVariants[item.variantKey] = {
              ...v,
              stockQuantity: newQty,
            };
          }
        }

        const oosKeys = recalcVariantOos(updatedVariants);
        const variantUpdates: Record<string, unknown> = {};
        for (const [key, v] of Object.entries(updatedVariants)) {
          variantUpdates[`variants.${key}.stockQuantity`] = v.stockQuantity;
        }

        tx.update(productRefs[i], {
          ...variantUpdates,
          outOfStockVariants: oosKeys,
          hasOutOfStockVariants: oosKeys.length > 0,
          totalStock: F.increment(totalStockDelta),
        });
      }
    });
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

    // Cancellation: restore stock + deduct revenue
    const items: Array<{
      productId: string;
      variantKey: string;
      quantity: number;
    }> = before.items ?? [];
    const productIds = [...new Set(items.map((i) => i.productId))];
    const productRefs = productIds.map((id) => db.doc(`products/${id}`));
    const revenue: number = before.totalAmount ?? 0;

    await db.runTransaction(async (tx) => {
      // ── Read phase ──────────────────────────────────────────────────────────
      const statsSnap = await tx.get(statsRef);
      const productSnaps = await Promise.all(productRefs.map((r) => tx.get(r)));

      const statsData = statsSnap.data() ?? {};
      const existingDaily: Record<string, number> = statsData.dailyRevenue ?? {};
      const existingMonthly: Record<string, number> =
        statsData.monthlyRevenue ?? {};

      const newDaily = pruneMap(
        existingDaily,
        todayKey(),
        -revenue,
        MAX_DAILY_DAYS
      );
      const newMonthly = pruneMap(
        existingMonthly,
        monthKey(),
        -revenue,
        MAX_MONTHLY_MONTHS
      );

      // ── Write phase ─────────────────────────────────────────────────────────
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
          lastUpdatedAt: F.serverTimestamp(),
        },
        { merge: true }
      );

      for (let i = 0; i < productIds.length; i++) {
        const productId = productIds[i];
        const productSnap = productSnaps[i];
        if (!productSnap.exists) continue;

        const productData = productSnap.data()!;
        const variants: Record<string, { stockQuantity: number }> =
          productData.variants ?? {};

        let totalStockDelta = 0;
        const updatedVariants = { ...variants };

        for (const item of items.filter((x) => x.productId === productId)) {
          const v = updatedVariants[item.variantKey];
          if (v) {
            const restored = v.stockQuantity + item.quantity;
            totalStockDelta += item.quantity;
            updatedVariants[item.variantKey] = { ...v, stockQuantity: restored };
          }
        }

        const oosKeys = recalcVariantOos(updatedVariants);
        const variantUpdates: Record<string, unknown> = {};
        for (const [key, v] of Object.entries(updatedVariants)) {
          variantUpdates[`variants.${key}.stockQuantity`] = v.stockQuantity;
        }

        tx.update(productRefs[i], {
          ...variantUpdates,
          outOfStockVariants: oosKeys,
          hasOutOfStockVariants: oosKeys.length > 0,
          totalStock: F.increment(totalStockDelta),
        });
      }
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
