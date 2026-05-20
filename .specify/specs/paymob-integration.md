# Phase 1: Foundation — OrderModel & Payment Enums

## Context

We're adding Paymob payment integration to Proper Store (Flutter e-commerce web app). This is Phase 1 — adding the data model foundations before building Cloud Functions or UI.

**Payment methods being added:**
- Online Card (Visa/MC) via Paymob
- Mobile Wallet (Vodafone Cash, Orange Cash) via Paymob
- Kiosk/Fawry via Paymob
- InstaPay (manual — customer pays externally, uploads screenshot, admin verifies)
- COD already exists

**Key architecture decision:** Online payment orders are created with status `awaitingPayment` BEFORE the customer pays. The webhook/admin confirmation transitions them to the existing order flow. This means `awaitingPayment` orders must NOT trigger inventory deduction.

## Task

### 1. Create `PaymentMethod` enum

Location: Decide based on existing patterns — likely in `packages/shared/lib/models/` or alongside `OrderModel`.

```dart
enum PaymentMethod {
  cod,        // Cash on Delivery (existing default)
  card,       // Visa/MC via Paymob
  wallet,     // Mobile Wallet via Paymob (Vodafone Cash, Orange Cash)
  kiosk,      // Fawry/Kiosk via Paymob
  instapay,   // Manual — customer pays externally, uploads screenshot
}
```

Add a `fromJson`/`toJson` helper or use `@JsonEnum` so it serializes as the enum name string (e.g., `"card"`, `"cod"`). Follow the same pattern used by `OrderStatus` in this codebase.

### 2. Create `PaymentStatus` enum

```dart
enum PaymentStatus {
  pending,              // COD orders — considered "paid" in the old sense (default for backward compat)
  awaitingPayment,      // Online payment order created, waiting for Paymob webhook
  pendingVerification,  // InstaPay — screenshot uploaded, waiting for admin
  paid,                 // Payment confirmed (by webhook or admin)
  failed,               // Payment failed (Paymob webhook returned success: false)
  expired,              // Payment window expired (cleanup function)
  rejected,             // InstaPay — admin rejected the payment
  refunded,             // Refunded via Paymob
  voided,               // Voided via Paymob
}
```

Same serialization pattern as `PaymentMethod`.

### 3. Update `OrderModel`

Add these new fields to the existing `OrderModel` (which uses `freezed` + `json_serializable`):

```dart
PaymentMethod paymentMethod    // Required — but with default for backward compat
PaymentStatus paymentStatus    // Required — but with default for backward compat
int? paymobOrderId             // Paymob's order ID from intention response
int? paymobTransactionId       // Paymob's transaction ID from webhook
String? paymentScreenshot      // Firebase Storage URL (InstaPay only)
```

**CRITICAL — Backward compatibility:** All existing orders in Firestore have NO `paymentMethod` or `paymentStatus` fields. The defaults MUST be:
- `paymentMethod` → `PaymentMethod.cod` (all existing orders are COD)
- `paymentStatus` → `PaymentStatus.pending` (existing COD orders — "pending" means they follow the old flow where COD is assumed paid)

Use `@JsonKey(defaultValue: ...)` or `@Default(...)` in the freezed class to handle missing fields in Firestore documents.

### 4. Update localization (ARB files)

Add localized strings for payment methods and statuses in both `intl_ar.arb` and `intl_en.arb` in the shared package:

**Arabic:**
- cod → "الدفع عند الاستلام"
- card → "بطاقة ائتمان"
- wallet → "محفظة إلكترونية"
- kiosk → "فوري"
- instapay → "إنستاباي"
- awaitingPayment → "في انتظار الدفع"
- pendingVerification → "في انتظار التحقق"
- paid → "تم الدفع"
- failed → "فشل الدفع"
- expired → "انتهت صلاحية الدفع"
- rejected → "تم رفض الدفع"
- refunded → "تم الاسترداد"
- voided → "تم الإلغاء"

**English:**
- cod → "Cash on Delivery"
- card → "Credit Card"
- wallet → "Mobile Wallet"
- kiosk → "Fawry"
- instapay → "InstaPay"
- awaitingPayment → "Awaiting Payment"
- pendingVerification → "Pending Verification"
- paid → "Paid"
- failed → "Payment Failed"
- expired → "Payment Expired"
- rejected → "Payment Rejected"
- refunded → "Refunded"
- voided → "Voided"

### 5. Run build_runner

After all changes, run from the shared package directory:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Rules
- Follow existing code patterns in the repo (check how OrderStatus is implemented)
- No comments unless intent isn't obvious
- snake_case.dart files, PascalCase types, camelCase everything else
- Don't manually edit generated files
- Minimal changes — only add what's described above
- Make sure the existing codebase still compiles after these changes (no breaking changes to existing code that uses OrderModel)


# Phase 2: Cloud Functions — Paymob Backend Integration

## Context

We're adding Paymob payment integration to Proper Store. Phase 1 (OrderModel updates, PaymentMethod/PaymentStatus enums) is already done. Now we're building the Cloud Functions that handle the server-side payment logic.

**Paymob API details:**
- Base URL (Egypt): `https://accept.paymob.com/`
- Create Intention endpoint: `POST https://accept.paymob.com/v1/intention/`
- Auth header: `Authorization: Token {SECRET_KEY}`
- Amount is in **cents** (piasters) — multiply EGP by 100
- Integration IDs (Test): Card=5593298, Wallet=5593500, Kiosk=5675590
- Response contains `client_secret` used for Unified Checkout redirect
- Unified Checkout URL: `https://accept.paymob.com/unifiedcheckout/?publicKey={PUBLIC_KEY}&clientSecret={CLIENT_SECRET}`

**Environment variables to use (I'll set these later — use these names):**
```
PAYMOB_SECRET_KEY      // Secret key for API auth
PAYMOB_PUBLIC_KEY      // Public key for checkout URL
PAYMOB_HMAC_SECRET     // HMAC secret for webhook verification
PAYMOB_CARD_INTEGRATION_ID
PAYMOB_WALLET_INTEGRATION_ID
PAYMOB_KIOSK_INTEGRATION_ID
PAYMOB_IS_LIVE         // "true" or "false" — for is_live check in webhook
```

## Task — 4 Cloud Functions

### Function 1: `createPaymentIntention` (callable)

**Purpose:** Called by the store app when customer selects online payment. Creates a pending order in Firestore, then creates a Paymob intention, returns the checkout URL data.

**Input (from client):**
```typescript
{
  paymentMethod: 'card' | 'wallet' | 'kiosk' | 'instapay',
  addressId: string,  // customer's selected address doc ID
}
```

**Logic:**
1. Verify the user is authenticated (auth.uid exists)
2. Validate `paymentMethod` is one of the allowed values
3. Read the user's cart from Firestore (`users/{uid}/cart`)
4. Read product details from Firestore for each cart item — **calculate total server-side** (DO NOT trust any amount from the client)
5. Read shipping cost from `storeConfig`
6. Calculate `totalAmountCents = (itemsTotal + shippingCost) * 100`
7. Read the user's address from Firestore (`users/{uid}/addresses/{addressId}`)
8. **Cancel any existing `awaitingPayment` orders** for this user (set their status to `expired`)
9. **If paymentMethod is `instapay`:** Create order with `paymentStatus: 'awaitingPayment'`, return `{ orderId, paymentMethod: 'instapay' }` — NO Paymob call needed
10. **If paymentMethod is `card`/`wallet`/`kiosk`:** Continue below

**For Paymob payment methods:**

10. Create a pending order document in Firestore (`orders/{autoId}`) with:
    - All order data (items with snapshot of product data, address, shipping, totals)
    - `paymentMethod`: the selected method
    - `paymentStatus`: `'awaitingPayment'`
    - `orderStatus`: `'awaitingPayment'` (new status — does NOT trigger inventory deduction)
    - `userId`: auth.uid
    - `createdAt`: epoch timestamp
    - Do NOT include `paymobOrderId` or `paymobTransactionId` yet

11. Map `paymentMethod` to integration ID:
    - `card` → PAYMOB_CARD_INTEGRATION_ID
    - `wallet` → PAYMOB_WALLET_INTEGRATION_ID
    - `kiosk` → PAYMOB_KIOSK_INTEGRATION_ID

12. Call Paymob Create Intention API:
```typescript
POST https://accept.paymob.com/v1/intention/
Headers:
  Authorization: Token {PAYMOB_SECRET_KEY}
  Content-Type: application/json
Body:
{
  "amount": totalAmountCents,  // in cents/piasters
  "currency": "EGP",
  "payment_methods": [integrationId],
  "items": cartItems.map(item => ({
    "name": item.productName,
    "amount": item.price * item.quantity * 100,  // cents
    "description": item.productName,
    "quantity": item.quantity
  })),
  "billing_data": {
    "first_name": address.firstName || user.displayName || "Customer",
    "last_name": address.lastName || "Customer",
    "email": user.email || "customer@store.com",
    "phone_number": address.phone || user.phoneNumber || "+201000000000",
    "apartment": address.apartment || "NA",
    "floor": address.floor || "NA",
    "street": address.street || "NA",
    "building": address.building || "NA",
    "city": address.city || "NA",
    "state": address.area || "NA",
    "country": "EG"
  },
  "special_reference": firestoreOrderDocId,
  "extras": {
    "firestoreOrderId": firestoreOrderDocId,
    "userId": auth.uid
  },
  "expiration": 3600,
  "notification_url": "https://{REGION}-{PROJECT_ID}.cloudfunctions.net/paymobWebhook",
  "redirection_url": "https://theproperstore.com/payment-result"
}
```

13. **If Paymob API fails:** Delete/expire the pending order, throw error to client
14. **If Paymob API succeeds:** Update the pending order with `paymobOrderId` from response (`intention_order_id`), then return:
```typescript
{
  orderId: firestoreOrderDocId,
  clientSecret: response.client_secret,
  publicKey: PAYMOB_PUBLIC_KEY,
  checkoutUrl: `https://accept.paymob.com/unifiedcheckout/?publicKey=${PAYMOB_PUBLIC_KEY}&clientSecret=${response.client_secret}`
}
```

**Error handling:** Wrap the Paymob API call in try-catch. If it fails after the Firestore order was created, mark the order as `failed` or delete it before returning error.

---

### Function 2: `paymobWebhook` (HTTP function — NOT callable)

**Purpose:** Receives POST callbacks from Paymob after payment events. This is the SOURCE OF TRUTH for payment status.

**CRITICAL: This is also configured in the Paymob Dashboard as the Transaction Processed Callback URL for all 3 integration IDs.**

**Logic:**

1. **Extract HMAC** from query params: `req.query.hmac`

2. **Extract transaction data** from request body: `req.body.obj`

3. **Handle `pending: true`:**
   ```
   if (obj.pending === true) {
     // Transaction still processing, wait for final callback
     return res.status(200).send('OK');
   }
   ```

4. **Verify HMAC (SHA-512):**
   Concatenate these field VALUES from `obj` in THIS EXACT ORDER (no separator):
   ```
   amount_cents
   created_at
   currency
   error_occured
   has_parent_transaction
   id                        // obj.id
   integration_id
   is_3d_secure
   is_auth
   is_capture
   is_refunded
   is_standalone_payment
   is_voided
   order.id                  // obj.order.id
   owner
   pending
   source_data.pan
   source_data.sub_type
   source_data.type
   success
   ```
   
   Calculate: `HMAC-SHA512(concatenatedString, PAYMOB_HMAC_SECRET)`
   Compare with received `hmac` query param.
   
   **If mismatch:** Log full details (for debugging config issues), return 403.

5. **Verify environment (test/live):**
   ```
   if (PAYMOB_IS_LIVE === 'true' && obj.is_live === false) return 400;
   if (PAYMOB_IS_LIVE === 'false' && obj.is_live === true) return 400;
   ```

6. **Verify currency:**
   ```
   if (obj.currency !== 'EGP') { log error; return 400; }
   ```

7. **Find the Firestore order** using this lookup chain:
   - Try `obj.order.merchant_order_id` (= our `special_reference` = Firestore doc ID)
   - If null, try finding order where `paymobOrderId == obj.order.id`
   - If null, try `obj.payment_key_claims.extra.firestoreOrderId`
   - If still not found: log error, return 200 (don't make Paymob keep retrying)

8. **Determine action based on callback type:**
   ```typescript
   if (obj.is_voided) {
     // Void callback
     newPaymentStatus = 'voided';
   } else if (obj.is_refunded) {
     // Refund callback
     newPaymentStatus = 'refunded';
   } else if (obj.success === true) {
     // Successful payment
     newPaymentStatus = 'paid';
   } else {
     // Failed payment
     newPaymentStatus = 'failed';
   }
   ```

9. **For successful payment — additional verifications:**
   - Verify `obj.amount_cents` matches order's `totalAmountCents`
   - If mismatch: log critical error, set `newPaymentStatus = 'failed'`, alert admin

10. **Atomic Firestore transaction:**
    ```typescript
    await firestore.runTransaction(async (transaction) => {
      const orderRef = firestore.doc(`orders/${orderId}`);
      const orderDoc = await transaction.get(orderRef);
      const currentStatus = orderDoc.data().paymentStatus;
      
      // Guard: already paid? (double payment detection)
      if (currentStatus === 'paid' && newPaymentStatus === 'paid') {
        // DOUBLE PAYMENT — log warning, alert admin
        // Store second transaction ID for admin to refund
        console.error('DOUBLE PAYMENT DETECTED', { orderId, transactionId: obj.id });
        return; // Don't update, but return 200 to Paymob
      }
      
      // Guard: only awaitingPayment orders can transition to paid
      if (newPaymentStatus === 'paid' && currentStatus !== 'awaitingPayment') {
        console.error('Unexpected status transition', { currentStatus, newPaymentStatus });
        return;
      }
      
      const updateData = {
        paymentStatus: newPaymentStatus,
        paymobTransactionId: obj.id,
        updatedAt: Date.now(),
      };
      
      // If payment succeeded, also update orderStatus to trigger inventory deduction
      if (newPaymentStatus === 'paid') {
        updateData.orderStatus = 'pending'; // This triggers existing inventory state machine
      }
      
      transaction.update(orderRef, updateData);
    });
    ```

11. **Return 200 on success, 500 on Firestore failure** (so Paymob retries on failure).

---

### Function 3: `reconcilePayments` (scheduled — every 15 minutes)

**Purpose:** Safety net for lost webhooks. Checks Paymob API for status of orders stuck in `awaitingPayment`.

**Logic:**
1. Query Firestore: orders where `paymentStatus == 'awaitingPayment'` AND `createdAt < (now - 10 minutes)` AND `paymentMethod in ['card', 'wallet', 'kiosk']`
2. For each order that has a `paymobOrderId`:
   - Call Paymob Retrieve Transaction API (by order ID)
   - If transaction found and successful → update order to `paid` (same atomic logic as webhook)
   - If transaction found and failed → update order to `failed`
   - If no transaction found → leave it (customer might not have started paying yet)
3. Limit to 20 orders per run to avoid timeout

**Paymob Retrieve Transaction API:**
```
GET https://accept.paymob.com/api/ecommerce/orders/{paymobOrderId}
Headers: Authorization: Token {PAYMOB_SECRET_KEY}
```
Response includes `paid_amount_cents` and related transaction data.

---

### Function 4: `cleanupExpiredOrders` (scheduled — daily)

**Purpose:** Expire stale pending orders that were never paid.

**Logic:**
1. Query: `paymentStatus == 'awaitingPayment'` AND `paymentMethod in ['card', 'wallet']` AND `createdAt < (now - 24 hours)`
   → Update to `paymentStatus: 'expired'`

2. Query: `paymentStatus == 'awaitingPayment'` AND `paymentMethod == 'kiosk'` AND `createdAt < (now - 72 hours)`
   → Update to `paymentStatus: 'expired'` (Kiosk gets longer window)

3. Query: `paymentStatus == 'pendingVerification'` AND `paymentMethod == 'instapay'` AND `createdAt < (now - 72 hours)`
   → Update to `paymentStatus: 'expired'`

**Note:** If a webhook arrives for an expired kiosk order (customer actually paid late), the webhook function should reactivate it: allow `expired` → `paid` transition for kiosk orders.

---

## Important Notes

- The existing order creation flow for COD should remain UNTOUCHED. Only add new paths for online payment.
- The existing Cloud Functions that handle inventory deduction are triggered by `orderStatus` changes. The new `awaitingPayment` orderStatus must NOT trigger inventory deduction. Only when webhook changes orderStatus to `'pending'` (the existing trigger status) should inventory be deducted.
- Check the existing Cloud Functions code to understand how inventory deduction is triggered, and make sure the new payment flow integrates correctly with it.
- All Paymob API keys come from environment variables — never hardcode them.
- Use structured logging (console.error/warn/info with objects) for all payment-related events.
- Follow existing Cloud Functions patterns in the repo (TypeScript, coding style, error handling).



# Phase 3: Store App — Paymob Checkout Flow

## Context

Phase 1 (OrderModel, PaymentMethod, PaymentStatus enums) and Phase 2 (Cloud Functions) are done. Now we're updating the store_app checkout flow to support online payment methods.

**Current checkout flow (COD):**
Customer fills address → selects COD → `CheckoutCubit.placeOrder()` → creates order in Firestore directly → navigates to success page

**New flow for Paymob payments:**
Customer fills address → selects payment method → if COD: existing flow → if Card/Wallet/Kiosk: call `createPaymentIntention` CF → get checkoutUrl → redirect to Paymob → customer pays → redirected back to return page → return page listens to Firestore order status

**New flow for InstaPay:**
Customer fills address → selects InstaPay → call `createPaymentIntention` CF → navigate to InstaPay instructions page → customer pays externally → uploads screenshot → order created with `pendingVerification`

## Task

### 1. Domain Layer (`packages/store_app/lib/features/checkout/domain/`)

**New repository interface** (`payment_repository.dart`):
```dart
abstract class PaymentRepository {
  Future<Either<Failure, PaymentIntentionResult>> createPaymentIntention({
    required PaymentMethod paymentMethod,
    required String addressId,
  });
}
```

**New entity** (`payment_intention_result.dart`):
```dart
// Use freezed
class PaymentIntentionResult {
  final String orderId;
  final String? clientSecret;    // null for InstaPay
  final String? publicKey;       // null for InstaPay
  final String? checkoutUrl;     // null for InstaPay
  final PaymentMethod paymentMethod;
}
```

**New use case** (`create_payment_intention_use_case.dart`):
```dart
class CreatePaymentIntentionUseCase {
  final PaymentRepository repository;
  // Standard call method following existing use case patterns in the repo
}
```

### 2. Data Layer (`packages/store_app/lib/features/checkout/data/`)

**New data source** (`payment_remote_data_source.dart`):
- Calls the `createPaymentIntention` Cloud Function using Firebase Functions callable
- Maps the response to the model

**New repository impl** (`payment_repository_impl.dart`):
- Implements PaymentRepository
- Uses the data source
- Maps exceptions to typed Failures (follow existing pattern in the codebase)

**Register with injectable** — annotate with `@LazySingleton(as: PaymentRepository)` etc.

### 3. Presentation Layer

#### Update `CheckoutCubit`

Add to the existing cubit (DON'T create a new one — extend the existing checkout flow):

**New states** (add to existing freezed states):
- `paymentIntentionLoading` — while calling CF
- `paymentIntentionCreated` — has `checkoutUrl`, `orderId`
- `paymentIntentionFailed` — has `failure` message
- `instapayOrderCreated` — has `orderId` (for InstaPay flow)

**New method:**
```dart
Future<void> initiatePayment({
  required PaymentMethod paymentMethod,
  required String addressId,
}) async {
  if (paymentMethod == PaymentMethod.cod) {
    // Existing COD flow — call existing placeOrder()
    return;
  }
  
  emit(paymentIntentionLoading);
  
  final result = await createPaymentIntentionUseCase(
    paymentMethod: paymentMethod,
    addressId: addressId,
  );
  
  result.fold(
    (failure) => emit(paymentIntentionFailed(failure)),
    (intention) {
      if (paymentMethod == PaymentMethod.instapay) {
        emit(instapayOrderCreated(orderId: intention.orderId));
      } else {
        emit(paymentIntentionCreated(
          checkoutUrl: intention.checkoutUrl!,
          orderId: intention.orderId,
        ));
      }
    },
  );
}
```

#### Payment Method Selector Widget

Create a widget that shows available payment methods for the checkout page:
- COD (existing — الدفع عند الاستلام)
- Credit Card (بطاقة ائتمان) — Visa/MC icons
- Mobile Wallet (محفظة إلكترونية) — Vodafone Cash, Orange icons
- Fawry (فوري) — Fawry icon/logo
- InstaPay (إنستاباي) — InstaPay icon

Use localized strings from S.of(context). Follow existing UI patterns. The selector should be added to the checkout page before the "Place Order" button.

#### Paymob Redirect Logic

When `paymentIntentionCreated` state is emitted:
- **Flutter Web:** Use `dart:html` → `html.window.location.href = checkoutUrl` (full redirect, not popup)
- This redirects the customer to Paymob's hosted checkout page
- After payment, Paymob redirects back to the `redirection_url`

#### Payment Return Page

Create a new route/page: `/payment-result`

This page:
1. On load, reads query params from the URL (`id`, `success`, `order` etc.)
2. Extracts the `special_reference` or `order` param to get the Firestore order ID
3. Sets up a **realtime Firestore listener** on the order document
4. Shows a loading spinner with "جاري التحقق من الدفع..." / "Verifying payment..."
5. When `paymentStatus` changes:
   - `paid` → Show success UI with order details, "View Order" button
   - `failed` → Show failure UI with "Try Again" / "Return to Cart" buttons
   - Still `awaitingPayment` after 30 seconds → Show "التحقق يستغرق وقتاً أطول..." with contact support option
6. **NEVER show "Payment Successful" based on query params alone** — always wait for Firestore

**CRITICAL:** This page must be a **public route** (no auth guard). The customer's auth token might have expired during the Paymob checkout. If not authenticated, show the payment status from query params as "provisional" and ask them to log in to see full details.

**Register the route** in GoRouter config.

#### InstaPay Instructions Page

Create a page that shows after `instapayOrderCreated`:
1. Shows InstaPay payment details (phone number / payment link from storeConfig)
2. Shows the order total
3. Has an "Upload Payment Screenshot" button
4. After upload: navigates to screenshot upload confirmation
5. Screenshot upload:
   - File picker (image only: jpg, png, webp)
   - Max 5MB validation
   - Upload to Firebase Storage: `payment-screenshots/{orderId}/{filename}`
   - Update order doc: `paymentScreenshot: downloadUrl`, `paymentStatus: 'pendingVerification'`
6. After upload success: Show confirmation page "تم استلام طلبك وجاري مراجعة الدفع"

### 4. Update the Checkout Page UI

Modify the existing checkout page to:
1. Add the payment method selector widget (before the submit button)
2. Change the submit button label based on selected method:
   - COD: "تأكيد الطلب" (existing)
   - Card/Wallet/Kiosk: "المتابعة للدفع"
   - InstaPay: "المتابعة للدفع"
3. On submit: call `initiatePayment()` instead of `placeOrder()` directly
4. Handle the new cubit states in BlocListener/BlocConsumer:
   - `paymentIntentionLoading`: show loading overlay
   - `paymentIntentionCreated`: trigger redirect to checkoutUrl
   - `paymentIntentionFailed`: show error snackbar
   - `instapayOrderCreated`: navigate to InstaPay instructions page

### 5. Update Orders Page

The user's orders list should now show:
- Payment method icon/label
- Payment status badge (especially for `awaitingPayment`, `pendingVerification`)
- For `awaitingPayment` Paymob orders: show a "Complete Payment" button that redirects to Paymob again (using stored `paymobOrderId` to recreate intention — or just create a new intention)

## Rules
- Follow existing code patterns — check how other features are structured
- Strict Clean Architecture: presentation → domain → data
- Cubits depend on use cases only
- All new classes must be registered with injectable/get_it
- Use freezed for models and states
- Use S.of(context) for all user-facing strings
- Handle loading/error/empty states
- Don't break existing COD checkout flow
- Run build_runner after adding freezed classes



# Phase 4: Admin Dashboard — Payment Verification & Management

## Context

Phases 1-3 are done. The store app now supports online payments (Paymob) and InstaPay. Now we need to update the admin dashboard to handle payment-related order management.

**What admins need to do:**
1. See payment method and status on every order
2. Verify InstaPay payments (view screenshot, confirm/reject)
3. Know when a double payment happened (alert)
4. Restrict status transitions based on payment method
5. See `awaitingPayment` and `pendingVerification` orders prominently

## Task

### 1. Update Orders List Screen

**Add payment indicators to each order card/row:**
- Payment method icon/label (COD, Card, Wallet, Fawry, InstaPay)
- Payment status badge with color coding:
  - `awaitingPayment` → Orange badge
  - `pendingVerification` → Yellow badge (should stand out — admin action needed)
  - `paid` → Green badge
  - `failed` → Red badge
  - `expired` → Grey badge
  - `rejected` → Red badge
  - `refunded` → Blue badge
  - `voided` → Grey badge

**Add filter/tab for `pendingVerification` orders** — admin needs quick access to orders waiting for their review. Consider adding a count badge.

**Sorting:** `pendingVerification` orders should be sortable/filterable to the top.

### 2. Update Order Detail Screen

**Show payment info section:**
- Payment Method (localized name)
- Payment Status (localized with badge color)
- Paymob Order ID (if exists — for reference when checking Paymob dashboard)
- Paymob Transaction ID (if exists)
- Payment Screenshot (if InstaPay — show clickable thumbnail that opens full image)

### 3. InstaPay Verification UI

When viewing an order with `paymentMethod: 'instapay'` and `paymentStatus: 'pendingVerification'`:

**Show the payment screenshot:**
- Clickable/zoomable image (use CachedNetworkImage)
- Full screen image view on tap

**Show two action buttons:**
- ✅ "تأكيد الدفع" / "Confirm Payment" — Green button
- ❌ "رفض الدفع" / "Reject Payment" — Red button

**Confirm Payment flow:**
1. Show confirmation dialog: "هل أنت متأكد من تأكيد استلام الدفع لهذا الطلب؟"
2. On confirm: Call a Cloud Function `confirmInstapayPayment` (or update Firestore directly via admin SDK if admin app uses it)
   - Set `paymentStatus: 'paid'`
   - Set `orderStatus: 'pending'` (triggers inventory deduction via existing state machine)
   - Set `paymentVerifiedBy: adminUserId`
   - Set `paymentVerifiedAt: timestamp`
3. Show success/error feedback

**Reject Payment flow:**
1. Show dialog with optional reason text field: "سبب الرفض (اختياري)"
2. On reject:
   - Set `paymentStatus: 'rejected'`
   - Set `paymentRejectionReason: reason` (if provided)
   - Set `paymentVerifiedBy: adminUserId`
3. Show success/error feedback

### 4. Order Status Transition Guards

**The admin's order status update controls must respect payment method:**

For `paymentMethod: 'card' | 'wallet' | 'kiosk'`:
- Admin CANNOT manually change `paymentStatus` — only the webhook does this
- Admin CAN change `orderStatus` (processing, shipped, delivered) only AFTER `paymentStatus == 'paid'`
- If `paymentStatus != 'paid'`, disable order status controls with message: "في انتظار تأكيد الدفع"

For `paymentMethod: 'instapay'`:
- Admin CAN confirm/reject payment (as described above)
- After confirming payment, normal order status flow applies

For `paymentMethod: 'cod'`:
- Existing flow, no changes

### 5. StoreConfig — InstaPay Settings

Add new fields to the store config management screen:

**New fields:**
- `instapayEnabled` (bool) — toggle to enable/disable InstaPay option
- `instapayPhoneNumber` (String) — the phone number to display to customers
- `instapayPaymentLink` (String?) — optional deep link for InstaPay payment
- `instapayInstructions` (String?) — optional custom instructions text

**UI:** Add an "InstaPay Settings" section/card in the store config page with these fields. Follow existing storeConfig UI patterns.

**Update the storeConfig model** in the shared package to include these fields (with defaults for backward compatibility: `instapayEnabled: false`).

### 6. Cloud Function: `confirmInstapayPayment` (callable)

**If the admin app uses callable Cloud Functions for mutations:**

```typescript
// Input
{ orderId: string, action: 'confirm' | 'reject', reason?: string }

// Logic
1. Verify caller is admin (check custom claims or admin collection)
2. Read order, verify paymentMethod == 'instapay' && paymentStatus == 'pendingVerification'
3. If action == 'confirm':
   - Atomic update: paymentStatus → 'paid', orderStatus → 'pending'
   - This triggers existing inventory deduction
4. If action == 'reject':
   - Update: paymentStatus → 'rejected', reason saved
5. Record who verified and when
```

**If the admin app writes directly to Firestore:** Then implement the transition guards in Firestore security rules instead (Phase 5).

## Rules
- Follow existing admin_app code patterns
- Use existing cubit/state patterns
- All strings localized via S.of(context) in AR and EN
- Handle loading/error states on all actions
- Use confirmation dialogs before destructive/irreversible actions
- `isUpdating` guard on buttons to prevent double-submit
- Minimal changes to existing order management code — add, don't rewrite





# Phase 5: Security Rules & Final Hardening

## Context

Phases 1-4 are done. The payment integration is functionally complete. Now we need to lock down security rules and add the final safety measures.

## Task

### 1. Firestore Security Rules — Orders Collection

Update the Firestore security rules for the `orders` collection. The critical rule: **clients must NEVER be able to set `paymentStatus` to `paid`, `refunded`, or `voided`**. Only Cloud Functions (admin SDK) can do this.

```javascript
match /orders/{orderId} {
  // Read: users can read their own orders, admins can read all
  allow read: if request.auth != null && 
    (resource.data.userId == request.auth.uid || isAdmin());

  // Create: authenticated users can create orders, but with restrictions
  allow create: if request.auth != null
    && request.auth.uid == request.resource.data.userId
    // paymentStatus must be one of the "client-safe" values on creation
    && request.resource.data.paymentStatus in ['pending', 'awaitingPayment']
    // Can't create an order as already paid
    && request.resource.data.paymentStatus != 'paid';

  // Update: very restricted from client side
  allow update: if request.auth != null
    && resource.data.userId == request.auth.uid
    // Client can only update specific fields
    && onlyChangedFields(['paymentScreenshot', 'paymentStatus', 'updatedAt'])
    // paymentStatus: client can only change TO 'pendingVerification' (InstaPay screenshot upload)
    && (
      !('paymentStatus' in request.resource.data) 
      || request.resource.data.paymentStatus == resource.data.paymentStatus
      || (
        resource.data.paymentStatus == 'awaitingPayment' 
        && request.resource.data.paymentStatus == 'pendingVerification'
        && resource.data.paymentMethod == 'instapay'
      )
    );

  // Delete: never from client
  allow delete: if false;
}

// Helper function
function onlyChangedFields(allowedFields) {
  return request.resource.data.diff(resource.data).affectedKeys().hasOnly(allowedFields);
}

// Admin check — adjust based on how your app identifies admins
function isAdmin() {
  return request.auth.token.admin == true;
}
```

**IMPORTANT:** Adjust these rules to match your existing Firestore rules patterns. The key constraints are:
- `paymentStatus: 'paid'` can ONLY be set by Cloud Functions (admin SDK bypasses rules)
- Client can transition `awaitingPayment → pendingVerification` only for InstaPay orders
- Client can set `paymentScreenshot` only on their own orders

### 2. Firebase Storage Security Rules — Payment Screenshots

```javascript
match /payment-screenshots/{orderId}/{fileName} {
  // Upload: only authenticated users, only images, max 5MB
  allow write: if request.auth != null
    && request.resource.size < 5 * 1024 * 1024
    && request.resource.contentType.matches('image/.*');
  
  // Read: authenticated users (admin or order owner)
  // Note: we can't easily check order ownership in Storage rules,
  // so we allow any authenticated user to read. The URL is not guessable.
  allow read: if request.auth != null;
}
```

### 3. Webhook Endpoint Security

The `paymobWebhook` Cloud Function is an HTTP endpoint (not callable), meaning it's publicly accessible. The ONLY protection is HMAC verification.

**Additional hardening:**
- Log the IP address of incoming webhook requests (for audit trail)
- Consider adding Paymob's IP addresses to an allowlist (if Paymob publishes them — check with their support)
- Rate limit: if you get more than 100 webhook calls per minute, something is wrong — log an alert

### 4. Environment Variable Validation

Add a startup check in Cloud Functions that verifies all required env vars are set:
```typescript
const requiredEnvVars = [
  'PAYMOB_SECRET_KEY',
  'PAYMOB_PUBLIC_KEY', 
  'PAYMOB_HMAC_SECRET',
  'PAYMOB_CARD_INTEGRATION_ID',
  'PAYMOB_WALLET_INTEGRATION_ID',
  'PAYMOB_KIOSK_INTEGRATION_ID',
  'PAYMOB_IS_LIVE',
];

for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    console.error(`MISSING REQUIRED ENV VAR: ${envVar}`);
    // Optionally throw to prevent function deployment
  }
}
```

### 5. Payment Return Page — Query Param Safety

The payment return page (`/payment-result`) receives query params from Paymob redirect. These can be spoofed.

**Rules for the return page:**
- DISPLAY query params as "provisional" status only (with a loading indicator)
- The REAL status comes from the Firestore listener
- NEVER trigger any business logic based on query params
- If query params say `success=true` but Firestore says `awaitingPayment` — show "Verifying..."
- If query params say `success=false` — show "Payment may have failed" but still check Firestore (webhook might say otherwise)

### 6. Admin Dashboard — Additional Guards

- Admin must not be able to confirm a Paymob payment manually (card/wallet/kiosk). Only the webhook or reconciliation function can do this.
- When admin views an order's Paymob transaction details, show them as read-only.
- Add audit logging: when admin confirms/rejects InstaPay, log who did it and when.

## Rules
- Test all rules by trying to write `paymentStatus: 'paid'` from the client — it should fail
- Test that Cloud Functions (admin SDK) can still write all statuses
- Test screenshot upload works with the new Storage rules
- Don't break existing Firestore rules for other collections





# Phase 6: Testing Checklist

## Context

All phases are implemented. Now we need to test the full flow using Paymob test credentials.

## Setup Before Testing

1. **Set environment variables** in Cloud Functions:
   ```bash
   firebase functions:config:set \
     paymob.secret_key="sk_test_..." \
     paymob.public_key="pk_test_..." \
     paymob.hmac_secret="..." \
     paymob.card_integration_id="5593298" \
     paymob.wallet_integration_id="5593500" \
     paymob.kiosk_integration_id="5675590" \
     paymob.is_live="false"
   ```
   Or if using Cloud Functions v2 with Secret Manager, set accordingly.

2. **Configure Paymob Dashboard callback URLs** for ALL 3 integration IDs:
   - Go to each integration ID settings
   - Set Transaction Processed Callback URL: `https://{REGION}-{PROJECT_ID}.cloudfunctions.net/paymobWebhook`
   - Set Transaction Response Callback URL: `https://theproperstore.com/payment-result`

3. **Enable Auto Callback Retrial** in Paymob Dashboard.

4. **Deploy Cloud Functions** to Firebase.

## Test Scenarios

### Test 1: Card Payment — Happy Path
1. Add items to cart
2. Go to checkout, fill address
3. Select "Credit Card"
4. Click "Continue to Payment"
5. Verify: loading shown while CF creates intention
6. Verify: redirected to Paymob Unified Checkout page
7. Pay with test card: **5123456789012346**, Exp: 01/39, CVV: 123, Name: Test Account
8. Complete 3D Secure (if prompted)
9. Verify: redirected back to `/payment-result`
10. Verify: page shows "Verifying..." then transitions to "Payment Successful"
11. Verify: order in Firestore has `paymentStatus: 'paid'`, `orderStatus: 'pending'`
12. Verify: inventory was deducted
13. Verify: order appears in admin dashboard with correct payment info

### Test 2: Card Payment — Declined
1. Same as Test 1 but use test card: **5123450000000008** (if this triggers decline, otherwise check Paymob docs for decline test card)
2. Verify: redirected back with failure indication
3. Verify: order in Firestore has `paymentStatus: 'failed'`
4. Verify: inventory was NOT deducted

### Test 3: Wallet Payment
1. Select "Mobile Wallet" at checkout
2. Pay with test wallet: **01010101010**, MPin: 123456, OTP: 123456
3. Verify same success flow as card payment

### Test 4: Kiosk (Fawry) Payment
1. Select "Fawry" at checkout
2. Verify: Paymob shows a reference number
3. Note: In test mode you may need to simulate the kiosk payment from Paymob dashboard
4. Verify: webhook arrives and order is updated

### Test 5: InstaPay Payment
1. Select "InstaPay" at checkout
2. Verify: InstaPay instructions page shown with phone number from storeConfig
3. Upload a test screenshot (any image)
4. Verify: image uploaded to Storage, order `paymentStatus: 'pendingVerification'`
5. In admin dashboard: verify order appears with screenshot
6. Click "Confirm Payment"
7. Verify: order `paymentStatus: 'paid'`, `orderStatus: 'pending'`
8. Verify: inventory deducted

### Test 6: InstaPay — Admin Rejects
1. Same as Test 5 but admin clicks "Reject Payment"
2. Verify: order `paymentStatus: 'rejected'`
3. Verify: inventory NOT deducted

### Test 7: Customer Abandons Payment
1. Start card payment checkout
2. On Paymob page, close the browser tab (don't pay)
3. Verify: order stays `awaitingPayment` in Firestore
4. Verify: after cleanup function runs, order becomes `expired`

### Test 8: Multiple Pending Orders Prevention
1. Start card payment (creates pending order A)
2. Go back, start another card payment (should cancel order A, create order B)
3. Verify: order A is `expired`, order B is `awaitingPayment`

### Test 9: COD Still Works
1. Go through full checkout with COD
2. Verify: existing flow is completely unchanged
3. Verify: order has `paymentMethod: 'cod'`, `paymentStatus: 'pending'`

### Test 10: Backward Compatibility
1. Check existing orders in Firestore (from before this feature)
2. Verify: they load correctly with default `paymentMethod: 'cod'`, `paymentStatus: 'pending'`
3. Verify: no crashes in store app or admin app when viewing old orders

### Test 11: HMAC Verification
1. Send a fake POST to the webhook URL with made-up data
2. Verify: returned 403 (HMAC mismatch)
3. Verify: no Firestore changes

### Test 12: Security Rules
1. From browser console (or a test script), try to write an order with `paymentStatus: 'paid'` directly to Firestore
2. Verify: write is rejected by security rules

### Test 13: Reconciliation Function
1. Create a card payment order (pending in Firestore)
2. Complete payment on Paymob
3. Temporarily disable the webhook (or don't configure callback URL)
4. Wait for reconciliation function to run (or trigger it manually)
5. Verify: order status updated to `paid` by the reconciliation function

## After All Tests Pass

1. Switch Paymob credentials to production (live keys)
2. Set `PAYMOB_IS_LIVE=true`
3. Update integration IDs to production IDs (create new integrations in Paymob dashboard for live)
4. Update callback URLs to production Cloud Function URLs
5. Do one real payment with a small amount to verify end-to-end
6. Monitor Cloud Functions logs for any errors during first few real transactions

