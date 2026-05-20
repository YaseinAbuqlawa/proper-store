# Contract: reconcilePayments

**Type**: Hybrid — per-order delayed Cloud Function + daily scheduled safety sweep
**Auth**: N/A (runs as admin SDK)

## Trigger

1. **Per-order delayed check**: Cloud Tasks enqueue (~10 minutes after order creation via createPaymentIntention). Targets a single specific order.
2. **Daily safety sweep**: Cloud Scheduler — runs once daily. Catches any orders missed by per-order checks.

## Behavior (Per-Order Check)

1. Receive orderId from Cloud Tasks payload
2. Read order document — verify `paymentStatus == 'awaitingPayment'` AND `paymentMethod in ['card', 'wallet', 'kiosk']`
3. If order no longer awaiting payment (already resolved by webhook): exit early
4. Call Paymob Retrieve Order API: `GET /api/ecommerce/orders/{paymobOrderId}`
5. If transaction found and successful: update order to `paid` + `orderStatus: pending` (same atomic logic as webhook)
6. If transaction found and failed: update order to `failed`
7. If no transaction found: skip (customer may not have started paying)
8. Write audit log entry with action `payment.reconciliation.resolved` or `payment.reconciliation.skipped`

## Behavior (Daily Safety Sweep)

1. Query Firestore: orders where `paymentStatus == 'awaitingPayment'` AND `createdAt < (now - 10 minutes)` AND `paymentMethod in ['card', 'wallet', 'kiosk']`
2. Limit to 20 orders per run (prevent timeout)
3. For each order with a `paymobOrderId`: same reconciliation logic as per-order check
4. Log all reconciled orders for audit trail

## Error Handling

- Individual order reconciliation failures are logged but do not abort the batch
- API rate limiting: sequential processing with reasonable delays between Paymob API calls
- Cloud Tasks retries: if the per-order function fails, Cloud Tasks will retry with exponential backoff
