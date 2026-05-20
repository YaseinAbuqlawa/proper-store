# Contract: cleanupExpiredOrders

**Type**: Firebase Scheduled Function (daily)
**Auth**: N/A (runs as admin SDK)

## Trigger

Cloud Scheduler — runs once daily.

## Behavior

1. **Card/Wallet orders** (24h expiry):
   - Query: `paymentStatus == 'awaitingPayment'` AND `paymentMethod in ['card', 'wallet']` AND `createdAt < (now - 24 hours)`
   - Update to `paymentStatus: expired`

2. **Kiosk orders** (72h expiry):
   - Query: `paymentStatus == 'awaitingPayment'` AND `paymentMethod == 'kiosk'` AND `createdAt < (now - 72 hours)`
   - Update to `paymentStatus: expired`

3. **InstaPay orders** (72h expiry):
   - Query: `paymentStatus == 'pendingVerification'` AND `paymentMethod == 'instapay'` AND `createdAt < (now - 72 hours)`
   - Update to `paymentStatus: expired`

## Special Case: Kiosk Late Payment

If a webhook arrives for an expired kiosk order (customer paid late at a physical kiosk), the webhook function MUST allow the `expired → paid` transition for kiosk orders and reactivate the order.

## Error Handling

- Batch updates in chunks (Firestore batch write limit: 500)
- Individual failures logged but do not abort the batch
- Log total expired count per category for monitoring
