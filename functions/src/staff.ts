import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

import { assertSuperAdmin, writeAuditLog } from "./helpers";
import { VALID_ROLES, StaffRole } from "./types";

const db = admin.firestore();
const auth = admin.auth();
const F = admin.firestore.FieldValue;

function actor(context: functions.https.CallableContext): {
  uid: string;
  role: string;
} {
  return {
    uid: context.auth!.uid,
    role: (context.auth!.token.role as string) ?? "unknown",
  };
}

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

    const a = actor(context);
    await writeAuditLog(db, {
      actorUid: a.uid,
      actorRole: a.role,
      action: "staff.create",
      targetId: userRecord.uid,
      after: { username: username.trim(), role },
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

    const beforeSnap = await db.doc(`staff/${uid}`).get();
    const oldRole = (beforeSnap.data()?.role as string) ?? "unknown";

    await auth.setCustomUserClaims(uid, { role });
    await db.doc(`staff/${uid}`).update({ role });

    const a = actor(context);
    await writeAuditLog(db, {
      actorUid: a.uid,
      actorRole: a.role,
      action: "staff.roleChange",
      targetId: uid,
      before: { role: oldRole },
      after: { role },
    });

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

    const a = actor(context);
    await writeAuditLog(db, {
      actorUid: a.uid,
      actorRole: a.role,
      action: "staff.passwordChange",
      targetId: uid,
    });

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

    const beforeSnap = await db.doc(`staff/${uid}`).get();
    const beforeData = beforeSnap.data();

    await auth.deleteUser(uid);
    await db.doc(`staff/${uid}`).delete();

    const a = actor(context);
    await writeAuditLog(db, {
      actorUid: a.uid,
      actorRole: a.role,
      action: "staff.delete",
      targetId: uid,
      before: beforeData
        ? { username: beforeData.username, role: beforeData.role }
        : undefined,
    });

    return { success: true };
  }
);
