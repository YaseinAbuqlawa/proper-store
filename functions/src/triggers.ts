import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { STATS_DOC } from "./constants";

const db = admin.firestore();
const F = admin.firestore.FieldValue;

export const onUserCreated = functions.firestore
  .document("customers/{uid}")
  .onCreate(async (snap) => {
    const uid = snap.id;

    // Fetch the Auth user to inspect the sign-in provider.
    let authUser: admin.auth.UserRecord;
    try {
      authUser = await admin.auth().getUser(uid);
    } catch {
      // Auth user already deleted or uid mismatch — skip.
      return;
    }

    const providerId = authUser.providerData?.[0]?.providerId ?? "";

    // Bot / scripted signup via email+password: delete the Auth account immediately
    // and do NOT count this as a real customer.
    if (providerId === "password") {
      await admin.auth().deleteUser(uid);
      return;
    }

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
