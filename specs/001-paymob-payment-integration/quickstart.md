# Quickstart: Paymob Payment Integration

**Date**: 2026-05-19 | **Feature**: 001-paymob-payment-integration

## Prerequisites

- Flutter SDK (3.x, null-safe Dart)
- Node.js 20 (for Cloud Functions)
- Firebase CLI (`firebase-tools`)
- Active Paymob account with test credentials

## Environment Setup

### 1. Paymob Test Credentials

Obtain from Paymob Dashboard and set via Firebase Secret Manager (secrets are encrypted, never in code or git):

```bash
firebase functions:secrets:set PAYMOB_SECRET_KEY
firebase functions:secrets:set PAYMOB_PUBLIC_KEY
firebase functions:secrets:set PAYMOB_HMAC_SECRET
firebase functions:secrets:set PAYMOB_CARD_INTEGRATION_ID
firebase functions:secrets:set PAYMOB_WALLET_INTEGRATION_ID
firebase functions:secrets:set PAYMOB_KIOSK_INTEGRATION_ID
```

Each command prompts for the value interactively. Access in Cloud Functions via `defineSecret()` from `firebase-functions/params`.

### 2. Paymob Dashboard Configuration

For ALL 3 integration IDs (card, wallet, kiosk):
- **Transaction Processed Callback URL**: `https://{REGION}-{PROJECT_ID}.cloudfunctions.net/paymobWebhook`
- **Transaction Response Callback URL**: `https://theproperstore.com/payment-result`
- Enable **Auto Callback Retrial**

### 3. Build & Run

```bash
# Shared package — regenerate models after adding payment enums/fields
cd packages/shared/
dart run build_runner build --delete-conflicting-outputs

# Store app — regenerate DI + freezed
cd packages/store_app/
dart run build_runner build --delete-conflicting-outputs

# Admin app — regenerate DI + freezed
cd packages/admin_app/
dart run build_runner build --delete-conflicting-outputs

# Cloud Functions — compile and deploy
cd functions/
npm run build
firebase deploy --only functions
```

### 4. Deploy Security Rules

```bash
# From project root
firebase deploy --only firestore:rules
firebase deploy --only storage
```

## Test Credentials

| Method | Test Value                      | Notes                    |
|--------|---------------------------------|--------------------------|
| Card   | `5123456789012346` Exp: 01/39 CVV: 123 | Successful payment |
| Wallet | Phone: `01010101010` MPin: `123456` OTP: `123456` | Test wallet |
| Kiosk  | —                               | Simulate from Paymob dashboard |

## Key Routes (store_app)

| Route               | Purpose                                    |
|---------------------|--------------------------------------------|
| `/checkout`         | Existing — now includes payment method selector |
| `/payment-result`   | NEW — post-redirect verification page      |
| `/instapay-instructions` | NEW — InstaPay transfer instructions + upload |

## Verification Checklist

- [ ] `createPaymentIntention` callable returns checkout URL
- [ ] Paymob redirect works and returns to `/payment-result`
- [ ] Webhook updates order status to `paid`
- [ ] COD checkout still works unchanged
- [ ] InstaPay screenshot upload saves to Storage
- [ ] Admin can confirm/reject InstaPay orders
- [ ] Firestore rules block client-side `paymentStatus: paid` writes
- [ ] Fake webhook (bad HMAC) returns 403
