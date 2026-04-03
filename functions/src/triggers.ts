import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { STATS_DOC } from "./constants";

const db = admin.firestore();
const F = admin.firestore.FieldValue;

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
