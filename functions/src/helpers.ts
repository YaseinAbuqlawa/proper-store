import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { MAX_DAILY_DAYS, MAX_MONTHLY_MONTHS, TOP_SELLING_LIMIT, TOP_SPENDERS_LIMIT } from "./constants";
import { OrderItem, SellingEntry, SpenderEntry } from "./types";

// ─── Auth ─────────────────────────────────────────────────────────────────────

export function assertSuperAdmin(context: functions.https.CallableContext): void {
  if (context.auth?.token?.role !== "superAdmin") {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only superAdmin can perform this action."
    );
  }
}

// ─── Date keys ────────────────────────────────────────────────────────────────

export function todayKey(): string {
  return new Date().toISOString().slice(0, 10); // YYYY-MM-DD
}

export function monthKey(): string {
  return new Date().toISOString().slice(0, 7); // YYYY-MM
}

// ─── Stats helpers ────────────────────────────────────────────────────────────

/**
 * Removes oldest entries from a date-keyed map to keep it within maxEntries.
 * Never allows negative values — floors each value at 0.
 */
export function pruneMap(
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
 * Upserts a customer into the top spenders list and returns the sorted top N.
 */
export function upsertTopSpenders(
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
 * Builds the top selling list by upserting each ordered item (with full variant details).
 */
export function upsertTopSelling(
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
        productId: item.productId,
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

// ─── Stock helpers ────────────────────────────────────────────────────────────

/**
 * Recalculates the outOfStockVariants array from a variants map.
 * A variant is OOS when stockQuantity <= 0.
 */
export function recalcVariantOos(
  variants: Record<string, { stockQuantity: number }>
): string[] {
  return Object.entries(variants)
    .filter(([, v]) => v.stockQuantity <= 0)
    .map(([key]) => key);
}

/**
 * Validates stock for all items against their product snapshots.
 * Throws HttpsError if any item is out of stock or the product is missing.
 */
export function validateStock(
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
 * Builds the Firestore variant stock update map for a single product,
 * decrementing stock for each ordered item.
 * Returns the dot-notation update map, recalculated OOS keys, and total stock delta.
 */
export function buildVariantStockUpdates(
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

// ─── Revenue prep (used in pruneMap wrapper calls) ────────────────────────────

export { MAX_DAILY_DAYS, MAX_MONTHLY_MONTHS };
