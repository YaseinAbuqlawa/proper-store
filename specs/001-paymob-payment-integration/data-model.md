# Data Model: Paymob Payment Integration

**Date**: 2026-05-19 | **Feature**: 001-paymob-payment-integration

## Entities

### PaymentMethod (new enum — shared package)

| Value     | Firestore String | Display (AR)         | Display (EN)      |
|-----------|-----------------|----------------------|-------------------|
| cod       | `"cod"`         | الدفع عند الاستلام    | Cash on Delivery  |
| card      | `"card"`        | بطاقة ائتمان          | Credit Card       |
| wallet    | `"wallet"`      | محفظة إلكترونية       | Mobile Wallet     |
| kiosk     | `"kiosk"`       | فوري                  | Fawry             |
| instapay  | `"instapay"`    | إنستاباي              | InstaPay          |

**Serialization**: Enum name string (matches existing `OrderStatus` pattern using `@JsonKey` converters).

### PaymentStatus (new enum — shared package)

| Value                | Firestore String          | Display (AR)              | Display (EN)            |
|----------------------|--------------------------|---------------------------|-------------------------|
| pending              | `"pending"`              | معلق                      | Pending                 |
| awaitingPayment      | `"awaitingPayment"`      | في انتظار الدفع            | Awaiting Payment        |
| pendingVerification  | `"pendingVerification"`  | في انتظار التحقق           | Pending Verification    |
| paid                 | `"paid"`                 | تم الدفع                   | Paid                    |
| failed               | `"failed"`               | فشل الدفع                  | Payment Failed          |
| expired              | `"expired"`              | انتهت صلاحية الدفع         | Payment Expired         |
| rejected             | `"rejected"`             | تم رفض الدفع               | Payment Rejected        |
| refunded             | `"refunded"`             | تم الاسترداد               | Refunded                |
| voided               | `"voided"`               | تم الإلغاء                 | Voided                  |

### OrderModel (modified — shared package)

**Existing fields** (unchanged):
- `id`, `customerId`, `products`, `totalPrice`, `discountTotal`, `netTotal`, `shippingAddress`, `status`, `createdAt`, `shippingCost`

**New fields**:

| Field                | Type            | Default                    | Nullable | Notes                              |
|----------------------|-----------------|----------------------------|----------|-------------------------------------|
| paymentMethod        | PaymentMethod   | `PaymentMethod.cod`        | No       | Replaces existing `String paymentMethod` |
| paymentStatus        | PaymentStatus   | `PaymentStatus.pending`    | No       | COD orders default to "pending"     |
| paymobOrderId        | int             | —                          | Yes      | Paymob's intention order ID         |
| paymobTransactionId  | int             | —                          | Yes      | Paymob's transaction ID from webhook |
| paymentScreenshot    | String          | —                          | Yes      | Firebase Storage URL (InstaPay)     |
| paymentVerifiedBy    | String          | —                          | Yes      | Admin UID who verified InstaPay     |
| paymentVerifiedAt    | int             | —                          | Yes      | Epoch ms when admin verified        |
| paymentRejectionReason | String        | —                          | Yes      | Reason for InstaPay rejection       |

**Backward compatibility**: `@Default(PaymentMethod.cod)` and `@Default(PaymentStatus.pending)` ensure existing Firestore documents (lacking these fields) deserialize without errors or data migration.

### OrderStatus (modified — shared package)

**New value added**:

| Value             | Notes                                                    |
|-------------------|----------------------------------------------------------|
| awaitingPayment   | New. Order created but payment not yet received. MUST NOT trigger inventory deduction. |

All existing values (`pending`, `confirmed`, `shipped`, `delivered`, `cancelled`, `refunded`) remain unchanged.

### PaymentIntentionResult (new entity — store_app checkout domain)

| Field          | Type           | Nullable | Notes                                 |
|----------------|----------------|----------|---------------------------------------|
| orderId        | String         | No       | Firestore order document ID           |
| clientSecret   | String         | Yes      | Null for InstaPay                     |
| publicKey      | String         | Yes      | Null for InstaPay                     |
| checkoutUrl    | String         | Yes      | Null for InstaPay                     |
| paymentMethod  | PaymentMethod  | No       | The method used                       |

### PaymentConfigModel (new model — shared package)

| Field                  | Type    | Default | Notes                                  |
|------------------------|---------|---------|----------------------------------------|
| cardEnabled            | bool    | false   | Toggle for credit card payments        |
| walletEnabled          | bool    | false   | Toggle for mobile wallet payments      |
| kioskEnabled           | bool    | false   | Toggle for Fawry/kiosk payments        |
| instapayEnabled        | bool    | false   | Toggle for InstaPay payments           |
| instapayPhoneNumber    | String  | —       | Phone number shown to customers        |
| instapayPaymentLink    | String  | —       | Optional deep link for InstaPay        |
| instapayInstructions   | String  | —       | Optional custom instructions text      |

**Firestore location**: `storeConfig/paymentConfig` document (dedicated sub-document under storeConfig collection).

## State Transitions

### PaymentStatus State Machine

```
                    ┌─────────────┐
                    │   pending   │  ← COD orders (default)
                    └─────────────┘

    ┌──────────────────────────────────────────────────────┐
    │                  awaitingPayment                      │ ← Created by createPaymentIntention
    └──────────┬──────────┬──────────┬──────────┬──────────┘
               │          │          │          │
               ▼          ▼          ▼          ▼
           ┌──────┐  ┌────────┐ ┌───────┐ ┌─────────────────────┐
           │ paid │  │ failed │ │expired│ │ pendingVerification │ ← InstaPay screenshot uploaded
           └──────┘  └────────┘ └───┬───┘ └──────┬──────┬───────┘
                                    │             │      │
                                    │             ▼      ▼
                                    │         ┌──────┐ ┌────────┐
                                    │         │ paid │ │rejected│
                                    │         └──────┘ └───┬────┘
                                    │                      │
                                    ▼                      ▼
                              ┌──────┐           ┌─────────────────────┐
                              │ paid │           │ pendingVerification │ ← Re-upload allowed
                              └──────┘           └─────────────────────┘
                          (kiosk late pay)
```

**Valid transitions**:
- `awaitingPayment → paid` (webhook confirms payment — Card/Wallet/Kiosk)
- `awaitingPayment → failed` (webhook reports failure)
- `awaitingPayment → expired` (cleanup function — timeout)
- `awaitingPayment → pendingVerification` (InstaPay screenshot uploaded by customer)
- `pendingVerification → paid` (admin confirms InstaPay)
- `pendingVerification → rejected` (admin rejects InstaPay)
- `pendingVerification → expired` (cleanup function — 72h timeout)
- `rejected → pendingVerification` (customer re-uploads screenshot)
- `expired → paid` (kiosk late payment confirmed by webhook)
- `paid → refunded` (via Paymob refund webhook)
- `paid → voided` (via Paymob void webhook)

**Forbidden client-side transitions**: Any transition TO `paid`, `refunded`, or `voided`.

### OrderStatus Integration

When `paymentStatus` transitions to `paid`:
- `orderStatus` is set to `pending` (by webhook or admin confirmation)
- This triggers the existing inventory deduction and fulfillment flow

When `orderStatus` is `awaitingPayment`:
- Inventory is NOT deducted
- Order appears in customer history but marked as "awaiting payment"

## Relationships

```
OrderModel ──has── PaymentMethod (enum field)
OrderModel ──has── PaymentStatus (enum field)
OrderModel ──has── OrderStatus (enum field, existing + new awaitingPayment value)
StoreConfig ──has── PaymentConfigModel (payment method toggles + InstaPay settings)
PaymentIntentionResult ──references── OrderModel.id (via orderId field)
```
