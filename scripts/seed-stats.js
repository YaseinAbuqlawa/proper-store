#!/usr/bin/env node
"use strict";

const admin = require("firebase-admin");
const path = require("path");

const serviceAccount = require(path.resolve(__dirname, "service-account.json"));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

db.doc("stats/dashboard")
  .set({
    totalRevenue: 0,
    totalOrders: 0,
    totalCustomers: 0,
    outOfStockCount: 0,
    ordersByStatus: {
      pending: 0,
      processing: 0,
      shipped: 0,
      delivered: 0,
      cancelled: 0,
    },
    dailyRevenue: {},
    monthlyRevenue: {},
    topSelling: [],
    topSpenders: [],
    lastUpdatedAt: admin.firestore.FieldValue.serverTimestamp(),
  })
  .then(() => {
    console.log("✓ stats/dashboard seeded successfully.");
    process.exit(0);
  })
  .catch((err) => {
    console.error("Error seeding stats:", err.message);
    process.exit(1);
  });
