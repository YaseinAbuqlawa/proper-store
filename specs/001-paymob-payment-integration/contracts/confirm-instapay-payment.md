# Contract: confirmInstapayPayment

**Type**: Firebase HTTPS Callable Function
**Auth**: Required (admin only — verified via custom claims or admin collection)

## Request

```typescript
{
  orderId: string,
  action: 'confirm' | 'reject',
  reason?: string              // optional, used only when action='reject'
}
```

## Response — Success

```typescript
{
  success: true,
  orderId: string,
  newPaymentStatus: 'paid' | 'rejected'
}
```

## Response — Error

| Code                  | Condition                                         |
|-----------------------|---------------------------------------------------|
| `unauthenticated`     | No valid Firebase auth token                      |
| `permission-denied`   | Caller is not an admin                            |
| `not-found`           | Order not found                                   |
| `failed-precondition` | Order is not InstaPay or not in `pendingVerification` status |
| `internal`            | Firestore transaction failed                      |

## Behavior

1. Verify caller is admin
2. Read order, verify `paymentMethod === 'instapay'` and `paymentStatus === 'pendingVerification'`
3. If `action === 'confirm'`:
   - Set `paymentStatus: paid`, `orderStatus: pending` (triggers inventory deduction)
   - Set `paymentVerifiedBy: adminUid`, `paymentVerifiedAt: timestamp`
4. If `action === 'reject'`:
   - Set `paymentStatus: rejected`
   - Set `paymentRejectionReason: reason` (if provided)
   - Set `paymentVerifiedBy: adminUid`
5. Return success with new status
