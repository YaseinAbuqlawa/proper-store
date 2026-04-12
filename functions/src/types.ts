import * as admin from "firebase-admin";

export const VALID_ROLES = ["superAdmin", "admin", "cs"] as const;
export type StaffRole = (typeof VALID_ROLES)[number];

export interface OrderItem {
  productId: string;
  variantKey: string;
  quantity: number;
  sellingPrice: number;
  discountValue: number;
  imageUrl: string;
  name: string;
}

export interface SpenderEntry {
  customerId: string;
  name: string;
  totalSpent: number;
  orderCount: number;
  refundCount?: number;
}

export interface SellingEntry {
  id: string;
  productId: string;
  productName: string;
  variantKey: string;
  variantName: string;
  imageUrl: string;
  totalSold: number;
  totalRefunded?: number;
}

export type ProductSnap = admin.firestore.DocumentSnapshot;
