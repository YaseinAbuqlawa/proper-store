#!/usr/bin/env node
"use strict";

const admin = require("firebase-admin");
const path = require("path");

const serviceAccount = require(path.resolve(__dirname, "service-account.json"));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function seed() {
  // Count products that currently have at least one OOS variant.
  const oosSnap = await db
    .collection("products")
    .where("hasOutOfStockVariants", "==", true)
    .get();
  const outOfStockCount = oosSnap.size;

  await db.doc("stats/dashboard").set({
    totalRevenue: 0,
    totalOrders: 0,
    totalCustomers: 0,
    outOfStockCount,
    ordersByStatus: {
      pending: 0,
      confirmed: 0,
      shipped: 0,
      delivered: 0,
      cancelled: 0,
    },
    dailyRevenue: {},
    monthlyRevenue: {},
    topSelling: [],
    topSpenders: [],
    lastUpdatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log(
    `✓ stats/dashboard seeded successfully (outOfStockCount: ${outOfStockCount}).`
  );
}

seed()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error("Error seeding stats:", err.message);
    process.exit(1);
  });
