import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { assertSuperAdmin } from "./helpers";
import { VALID_ROLES, StaffRole } from "./types";

const db = admin.firestore();
const auth = admin.auth();
const F = admin.firestore.FieldValue;

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
