# Contract: paymobWebhook

**Type**: Firebase HTTPS Function (NOT callable — public HTTP endpoint)
**Auth**: HMAC-SHA512 signature verification via query param

## Request

**Method**: POST
**Query Params**: `?hmac={hmac_signature}`
**Body**: Paymob transaction callback object

```typescript
{
  obj: {
    id: number,                    // transaction ID
    pending: boolean,
    success: boolean,
    is_voided: boolean,
    is_refunded: boolean,
    is_live: boolean,
    is_3d_secure: boolean,
    is_auth: boolean,
    is_capture: boolean,
    is_standalone_payment: boolean,
    amount_cents: number,
    currency: string,
    created_at: string,
    error_occured: boolean,
    has_parent_transaction: boolean,
    integration_id: number,
    owner: number,
    order: {
      id: number,                  // Paymob order ID
      merchant_order_id: string    // our Firestore order doc ID
    },
    source_data: {
      pan: string,
      sub_type: string,
      type: string
    },
    payment_key_claims: {
      extra: {
        firestoreOrderId: string,
        userId: string
      }
    }
  }
}
```

## Response

| HTTP Status | Condition                                      |
|-------------|-------------------------------------------------|
| 200         | Processed successfully (or pending=true skip)  |
| 200         | Order not found (don't trigger Paymob retries) |
| 400         | Environment mismatch (test/live) or wrong currency |
| 403         | HMAC verification failed                        |
| 500         | Firestore transaction failed (triggers retry)   |

## Behavior

1. If `obj.pending === true`: return 200 immediately (intermediate callback)
2. Verify HMAC-SHA512 (concatenate 21 fields in exact order, compare hash)
3. Verify environment (test vs live matches config)
4. Verify currency is EGP
5. Locate Firestore order via lookup chain: `merchant_order_id` → `paymobOrderId` match → `extras.firestoreOrderId`
6. Determine new payment status: voided > refunded > success(paid) > failed
7. For successful payments: verify `amount_cents` matches order total. On mismatch: mark `paymentStatus: failed`, log critical alert with expected vs. received amounts to `auditLogs` (action: `payment.webhook.amount_mismatch`), return HTTP 200 (prevent retries). Do NOT confirm the order.
8. Atomic Firestore transaction: guard against double payments, validate status transition, update payment status + transaction ID
9. If payment succeeded and amount matches: set `orderStatus: pending` (triggers inventory deduction)
