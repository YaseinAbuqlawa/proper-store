#!/usr/bin/env node
"use strict";

const admin = require("firebase-admin");
const path = require("path");

const uid = process.argv[2];

if (!uid) {
  console.error("Usage: node set-super-admin.js <uid>");
  process.exit(1);
}

const serviceAccount = require(path.resolve(__dirname, "service-account.json"));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

admin
  .auth()
  .setCustomUserClaims(uid, { role: "superAdmin" })
  .then(() => {
    console.log(`✓ superAdmin claim set for uid: ${uid}`);
    process.exit(0);
  })
  .catch((err) => {
    console.error("Error setting custom claim:", err.message);
    process.exit(1);
  });
