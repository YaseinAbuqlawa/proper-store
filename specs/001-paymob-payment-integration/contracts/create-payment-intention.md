# Contract: createPaymentIntention

**Type**: Firebase HTTPS Callable Function
**Auth**: Required (Firebase Auth UID)

## Request

```typescript
{
  paymentMethod: 'card' | 'wallet' | 'kiosk' | 'instapay',
  addressId: string   // customer's selected address document ID
}
```

## Response — Success

```typescript
// For card/wallet/kiosk:
{
  orderId: string,
  clientSecret: string,
  publicKey: string,
  checkoutUrl: string    // full Paymob Unified Checkout URL
}

// For instapay:
{
  orderId: string,
  paymentMethod: 'instapay'
}
```

## Response — Error

| Code                  | Condition                                          |
|-----------------------|----------------------------------------------------|
| `unauthenticated`     | No valid Firebase auth token                       |
| `invalid-argument`    | Invalid paymentMethod or missing addressId         |
| `not-found`           | Address not found for this user                    |
| `failed-precondition` | Cart is empty or products unavailable              |
| `internal`            | Paymob API call failed (order rolled back)         |

## Behavior

1. Validates auth and input
2. Reads cart items from `customers/{uid}/cart` — uses server-locked prices (written by addToCart CF, not client-editable per FR-025)
3. Calculates order total from server-locked cart prices + shipping cost from `storeConfig`
4. Reads shipping cost from `storeConfig`
5. Cancels any existing `awaitingPayment` orders for this user (sets to `expired`)
6. Creates order document in `orders/` with `orderStatus: awaitingPayment`, `paymentStatus: awaitingPayment`
7. For instapay: returns `{ orderId, paymentMethod }` — no Paymob API call
8. For card/wallet/kiosk: calls Paymob Create Intention API with appropriate integration ID, updates order with `paymobOrderId`, returns checkout URL data. Enqueues a Cloud Tasks delayed reconciliation check (~10 minutes)
9. If Paymob API fails after order creation: marks order as `failed`, throws `internal` error
