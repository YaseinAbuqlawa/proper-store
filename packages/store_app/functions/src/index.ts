import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

export const checkSmsLimit = functions.https.onCall(async (request) => {

    const phoneNumber = request.data.phoneNumber;

    if (!phoneNumber) {
        throw new functions.https.HttpsError('invalid-argument', 'رقم الهاتف مطلوب');
    }

    const userRef = db.collection('otp_limits').doc(phoneNumber);
    const now = Date.now();
    const oneDay = 24 * 60 * 60 * 1000;

    try {
        await db.runTransaction(async (transaction) => {
            const doc = await transaction.get(userRef);

            if (!doc.exists) {
                transaction.set(userRef, { count: 1, lastAttempt: now });
            } else {
                const userData = doc.data()!;
                const lastAttempt = userData.lastAttempt || 0;
                let count = userData.count || 0;

                if (now - lastAttempt > oneDay) {
                    transaction.update(userRef, { count: 1, lastAttempt: now });
                } else if (count >= 3) {
                    throw new functions.https.HttpsError('resource-exhausted', 'لقد تجاوزت 3 محاولات، حاول بعد 24 ساعة.');
                } else {
                    transaction.update(userRef, { count: count + 1, lastAttempt: now });
                }
            }
        });

        return { success: true };
    } catch (error: any) {
        if (error instanceof functions.https.HttpsError) throw error;
        throw new functions.https.HttpsError('internal', error.message);
    }
});