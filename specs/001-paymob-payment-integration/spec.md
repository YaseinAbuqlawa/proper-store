# Feature Specification: Paymob Payment Integration & InstaPay Manual Payment

**Feature Branch**: `001-paymob-payment-integration`

**Created**: 2026-05-19

**Status**: Draft

**Input**: User description: "Adding Paymob payment integration (Card, Wallet, Kiosk) and InstaPay manual payment to the store_app checkout flow, with admin verification, backend Cloud Functions, security hardening, and full testing."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Customer Pays with Credit Card Online (Priority: P1)

A customer browsing the store adds items to their cart and proceeds to checkout. After filling in their shipping address, they select "Credit Card" as their payment method. The system creates a pending order and redirects them to a secure hosted payment page. The customer enters their card details, completes any required verification, and is redirected back to the store. The store shows a real-time verification screen that confirms the payment was successful and the order is now being processed.

**Why this priority**: Online card payment is the highest-value payment method, enabling immediate revenue capture and reducing COD-related risks (refusals, cash handling). It is the primary revenue driver for this feature.

**Independent Test**: Can be fully tested by completing a card checkout end-to-end — from cart to payment confirmation — and verifying the order appears with "paid" status in both the customer's order history and the admin dashboard.

**Acceptance Scenarios**:

1. **Given** a customer has items in their cart and a saved address, **When** they select "Credit Card" and proceed to payment, **Then** the system creates a pending order and redirects them to the hosted payment page within 5 seconds.
2. **Given** a customer completes card payment successfully on the hosted page, **When** they are redirected back to the store, **Then** the verification screen shows "Payment Successful" and the order status transitions to processing.
3. **Given** a customer's card payment is declined, **When** they are redirected back, **Then** the store shows a clear failure message with options to retry or return to cart, and no inventory is deducted.
4. **Given** an existing COD customer places an order using COD, **When** they complete checkout, **Then** the existing COD flow works identically to before this feature was added.

---

### User Story 2 - Customer Pays via InstaPay (Manual Transfer) (Priority: P2)

A customer selects "InstaPay" at checkout. The store creates a pending order and shows them the store's InstaPay payment details (phone number or payment link) along with the total amount. The customer makes the transfer externally using their banking app, then returns to the store and uploads a screenshot of the payment confirmation. The order is marked as "pending verification" and the customer sees a confirmation that their order is being reviewed.

**Why this priority**: InstaPay is the most popular digital payment method in Egypt, serving customers who prefer bank transfers over card payments. It requires no integration fees per transaction, making it highly cost-effective.

**Independent Test**: Can be fully tested by selecting InstaPay at checkout, viewing the payment instructions, uploading a screenshot image, and verifying the order appears in admin as "pending verification" with the screenshot attached.

**Acceptance Scenarios**:

1. **Given** a customer selects InstaPay at checkout, **When** the order is created, **Then** the store displays the store's InstaPay phone number, payment link (if configured), and the exact amount to transfer.
2. **Given** a customer has made the InstaPay transfer, **When** they upload a screenshot (image file, max 5 MB), **Then** the screenshot is saved and the order is marked "pending verification" with a confirmation message shown.
3. **Given** a customer tries to upload a file larger than 5 MB or a non-image file, **When** they attempt the upload, **Then** the system shows a clear validation error and does not accept the file.
4. **Given** an admin has rejected the customer's InstaPay payment, **When** the customer views the order, **Then** they see the "rejected" status and can upload a new payment screenshot on the same order without starting a new checkout.

---

### User Story 3 - Admin Verifies InstaPay Payment (Priority: P2)

An admin with `superAdmin` or `admin` role opens the admin dashboard and sees orders marked "pending verification" prominently listed. They open an InstaPay order, view the uploaded payment screenshot in full detail, and either confirm or reject the payment. A `cs` (Customer Service) admin can view payment details but cannot confirm or reject payments. Upon confirmation, the order transitions into the normal fulfillment flow (inventory deducted, order processing begins). Upon rejection, the order is marked as rejected with an optional reason.

**Why this priority**: Without admin verification, InstaPay orders cannot proceed. This is the operational counterpart to User Story 2 and must be built alongside it.

**Independent Test**: Can be tested by creating an InstaPay order with a screenshot, then confirming or rejecting it from the admin dashboard and verifying the order status and inventory changes.

**Acceptance Scenarios**:

1. **Given** an InstaPay order is pending verification, **When** the admin views the order details, **Then** the payment screenshot is displayed as a clickable, zoomable image alongside the order details.
2. **Given** the admin confirms an InstaPay payment, **When** they click "Confirm Payment" and confirm the dialog, **Then** the order payment status becomes "paid", the order enters the normal fulfillment flow, and inventory is deducted.
3. **Given** the admin rejects an InstaPay payment, **When** they click "Reject Payment" and optionally provide a reason, **Then** the order payment status becomes "rejected", inventory is NOT deducted, and the rejection reason is recorded.
4. **Given** an admin views a card/wallet/kiosk order, **When** they try to change the payment status, **Then** the system prevents manual payment status changes for automated payment methods (only the payment processor can update these).

---

### User Story 4 - Customer Pays via Mobile Wallet (Priority: P3)

A customer selects "Mobile Wallet" (Vodafone Cash, Orange Cash) at checkout. The flow is identical to card payment — a pending order is created, the customer is redirected to the hosted payment page where they enter their wallet credentials, and upon success they are redirected back to the store with real-time verification.

**Why this priority**: Mobile wallets are a growing payment method in Egypt but have lower adoption than card and InstaPay. The technical infrastructure is shared with card payments, making this low incremental effort.

**Independent Test**: Can be tested by selecting Mobile Wallet at checkout, completing payment with test wallet credentials, and verifying the order is confirmed.

**Acceptance Scenarios**:

1. **Given** a customer selects Mobile Wallet and proceeds, **When** they complete wallet authentication on the hosted page, **Then** they are redirected back and the order is confirmed as paid.

---

### User Story 5 - Customer Pays via Kiosk/Fawry (Priority: P3)

A customer selects "Fawry" at checkout. The system creates a pending order and the hosted payment page provides a reference number. The customer visits a physical Fawry kiosk or uses the Fawry app to pay using that reference number. The payment webhook updates the order status asynchronously.

**Why this priority**: Kiosk payment serves the unbanked population but has the longest payment window (up to 72 hours). The technical infrastructure is shared with other payment methods.

**Independent Test**: Can be tested by selecting Fawry, verifying a reference number is generated, simulating the kiosk payment, and verifying the order is updated.

**Acceptance Scenarios**:

1. **Given** a customer selects Fawry and proceeds, **When** the hosted page shows a reference number, **Then** the customer has up to 72 hours to complete payment at a kiosk.
2. **Given** a kiosk payment is received after the standard expiry window but within the extended kiosk window, **When** the payment confirmation arrives, **Then** the order is reactivated and processed normally.

---

### User Story 6 - System Reconciles and Cleans Up Stale Orders (Priority: P3)

The system periodically checks for orders stuck in "awaiting payment" status. For orders with a payment processor reference, the system checks the processor's records to see if payment was actually received (handling cases where the webhook was lost). For orders that remain unpaid past their expiry window, the system automatically marks them as expired.

**Why this priority**: This is a safety net that prevents revenue loss from lost webhooks and keeps the order database clean. It runs automatically with no user interaction required.

**Independent Test**: Can be tested by creating an order, simulating a lost webhook, and verifying the reconciliation function detects and updates the payment status.

**Acceptance Scenarios**:

1. **Given** a card/wallet order has been "awaiting payment" for more than 10 minutes, **When** the reconciliation process runs, **Then** it checks the payment processor and updates the order status accordingly (paid or failed).
2. **Given** a card/wallet order has been unpaid for more than 24 hours, **When** the cleanup process runs, **Then** the order is marked as expired.
3. **Given** a kiosk order has been unpaid for more than 72 hours, **When** the cleanup process runs, **Then** the order is marked as expired.
4. **Given** an InstaPay order has been "pending verification" for more than 72 hours with no admin action, **When** the cleanup process runs, **Then** the order is marked as expired.

---

### User Story 7 - Payment Security and Integrity (Priority: P1)

The system ensures that payment statuses can only be set to "paid" by trusted server-side processes (payment processor webhooks or admin verification for InstaPay). Customers cannot manipulate their own payment status. All webhook communications are verified for authenticity. The payment return page never trusts redirect parameters for business logic — it always verifies payment status from the authoritative data source.

**Why this priority**: Payment security is non-negotiable. Without it, the entire payment system is vulnerable to fraud. This is architecturally foundational and must be built into every phase.

**Independent Test**: Can be tested by attempting to directly write "paid" status from a client — the operation must be rejected. Can also be tested by sending a fake webhook with invalid authentication — it must be rejected with no data changes.

**Acceptance Scenarios**:

1. **Given** a client attempts to directly set an order's payment status to "paid", **When** the write is attempted, **Then** the system rejects the write.
2. **Given** a webhook request arrives with an invalid authentication signature, **When** the system processes it, **Then** it returns a 403 rejection and makes no data changes.
3. **Given** a customer is redirected back from payment with "success=true" in the URL, **When** the return page loads, **Then** it shows a "Verifying..." state and waits for authoritative confirmation from the data source, not the URL parameters.
4. **Given** two identical payment confirmations arrive for the same order (double payment), **When** the system processes the second one, **Then** it detects the duplicate, logs a critical alert for admin review, and does not double-process the order.

---

### Edge Cases

- What happens when a customer starts an online payment, abandons it, and starts a new one? The system must cancel/expire the previous pending order before creating a new one. Only one "awaiting payment" order per customer at a time.
- What happens when the payment processor's redirect back to the store fails (browser crash, network issue)? The customer can check their order history — the webhook still updates the order status independently of the redirect.
- What happens when an order is expired by the cleanup function but the customer actually paid late (kiosk)? For kiosk orders, the system should allow the "expired to paid" transition and reactivate the order.
- What happens when the store's payment processor account has invalid or missing credentials? The system validates all required credentials at startup and logs critical errors. Payment creation fails gracefully with a user-friendly error message.
- What happens when existing orders (created before this feature) are loaded? They must display correctly with default values: payment method as "Cash on Delivery" and payment status as "pending". No crashes or data corruption.
- What happens when a customer's session expires while they are on the external payment page? The payment return page must be accessible without an active session, showing provisional status and prompting the customer to log in for full details.

## Clarifications

### Session 2026-05-19

- Q: When should the customer's cart be cleared for online (non-COD) payments? → A: Clear cart only after payment is confirmed as "paid". Cart is preserved if payment fails or expires, allowing the customer to retry without re-adding items.
- Q: After an admin rejects an InstaPay payment, can the customer re-upload a screenshot on the same order? → A: Yes. The customer sees "rejected" status and can upload a new screenshot on the same order (rejected → pendingVerification transition allowed). No need to create a new order.
- Q: Should the system send customer notifications for payment status changes? → A: Out of scope. Deferred to a future feature. Customers check their order history for status updates.
- Q: Should admins be able to enable/disable individual Paymob payment methods (Card, Wallet, Kiosk) from the dashboard? → A: Yes. Each payment method has its own enable/disable toggle in admin storeConfig, giving the store operational flexibility without code changes.
- Q: Which admin roles can verify/reject InstaPay payments and configure payment settings? → A: superAdmin and admin can verify/reject InstaPay payments and configure payment settings. cs (Customer Service) role is view-only for all payment information.
- Q: What are the valid payment status transitions per payment method? → A: Explicit per-method allow-list. COD: pending → paid. Card/Wallet: awaitingPayment → paid/failed/expired. Kiosk: awaitingPayment → paid/expired, expired → paid (late payment). InstaPay: pendingVerification → paid/rejected, rejected → pendingVerification (re-upload). All methods: any non-terminal → voided (admin override). Enforced in Cloud Functions and security rules.
- Q: Where should InstaPay payment screenshots be stored? → A: Firebase Storage in a dedicated path `instapay-screenshots/{orderId}/`. Download URL saved in the order document. Security rules: only the order owner can upload, only admins (superAdmin/admin) can read. Max 5 MB, image files only.
- Q: How should payment reconciliation and cleanup be scheduled? → A: Hybrid approach. Per-order delayed check (~10 minutes after order creation) triggers a Cloud Function to verify that specific order's payment status with Paymob. A daily safety sweep catches any orders that slipped through the per-order check and expires stale unpaid orders (24h card/wallet, 72h kiosk, 72h unverified InstaPay).
- Q: Where should Paymob API credentials be stored? → A: Cloud Functions environment config / Firebase Secret Manager. All credentials (API key, HMAC secret, integration IDs) are server-side only, never exposed to clients or stored in Firestore. Validated on Cloud Functions deployment or first invocation.

### Session 2026-05-20

- Q: Which order payment fields can clients write directly? → A: None. All payment-related fields (paymentStatus, paymentMethod, paymentProcessorOrderId, paymentProcessorTxnId, paymentScreenshotUrl, paymentAmount) are write-protected from clients via Firestore security rules. Only Cloud Functions (Admin SDK) can set these. The client creates orders with cart items + shipping address only; a Cloud Function populates all payment fields.
- Q: How should webhook replay attacks be prevented? → A: Idempotency check. Store each processed webhook's transaction ID. Reject any webhook with a previously-seen transaction ID. Combined with FR-008 atomic transactions, this prevents replay attacks without timestamp complexity.
- Q: How should product prices be secured against client tampering? → A: Server-side cart pricing. The add-to-cart operation calls a Cloud Function that fetches the current product price and writes it to the cart item. Firestore security rules prevent clients from writing the price field. The price is locked at cart-add time (the price the customer saw). At order creation, the CF trusts these locked prices because only CFs could have set them.
- Q: Should payment operations be audit-logged? → A: Yes. All payment state changes logged to the existing `auditLogs` collection: webhook processing, admin verify/reject (which admin + reason), reconciliation actions, expired-order cleanup. Each entry includes before/after payment status, actor (system/admin UID), timestamp, and order ID.
- Q: How should the webhook endpoint be protected against DoS/flooding? → A: HMAC verification for authenticity + rate limiting (max 100 requests/minute per IP). Excessive requests are logged and dropped before HMAC processing to minimize cost.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST support five payment methods: Cash on Delivery (existing), Credit Card, Mobile Wallet, Kiosk/Fawry, and InstaPay.
- **FR-002**: System MUST create orders with "awaiting payment" status before redirecting customers to the external payment page. These orders MUST NOT trigger inventory deduction.
- **FR-003**: System MUST calculate order totals server-side from product prices, discounts, and shipping costs. Client-provided amounts MUST NOT be trusted for payment processing. Product prices used for order totals MUST come from server-locked cart prices (see FR-025). Discounts (if any) MUST be validated and applied server-side by the createPaymentIntention Cloud Function.
- **FR-003a**: System MUST NOT clear the customer's cart until payment is confirmed as "paid". For failed, expired, or abandoned online payments, the cart MUST remain intact so the customer can retry without re-adding items.
- **FR-004**: System MUST cancel any existing "awaiting payment" orders for a customer before creating a new pending payment order (one pending payment per customer).
- **FR-005**: System MUST redirect customers to a hosted payment page for Card, Wallet, and Kiosk payments, and display manual transfer instructions for InstaPay.
- **FR-006**: System MUST verify payment webhook authenticity using HMAC-SHA512 signature verification before processing any payment status update.
- **FR-007**: System MUST verify that the payment amount matches the order total before confirming payment. On mismatch: the webhook MUST reject the payment (mark `paymentStatus: failed`), log a critical alert with expected vs. received amounts, and return HTTP 200 (to prevent Paymob retries). The order is NOT confirmed.
- **FR-008**: System MUST use atomic transactions when updating payment and order status to prevent race conditions and double-processing.
- **FR-009**: System MUST provide a payment return page that shows real-time payment verification status from the authoritative data source, never relying solely on URL redirect parameters.
- **FR-009a**: Payment return page MUST be accessible without active Firebase authentication. If the user's session expired during external payment, the page calls a `getOrderPaymentStatus` Cloud Function (no auth required, rate-limited) that returns minimal payment status by orderId. The orderId (Firestore auto-generated ID) acts as a capability token — unguessable and sufficient for read-only status access. If authenticated, the page uses a direct Firestore listener for real-time updates. The page MUST NOT block on auth — the webhook updates the order independently.
- **FR-010**: System MUST allow InstaPay customers to upload a payment screenshot (image only, max 5 MB) to Firebase Storage at `instapay-screenshots/{uid}/{orderId}/`. The path encodes ownership via `{uid}` for Storage rule enforcement without Firestore queries. The download URL MUST be saved in the order document via the `uploadInstapayScreenshot` Cloud Function. Storage security rules MUST restrict upload to the authenticated user matching `{uid}` and read access to `superAdmin`/`admin` roles.
- **FR-011**: System MUST allow admins with `superAdmin` or `admin` role to confirm or reject InstaPay payments from the admin dashboard, with an optional rejection reason. The `cs` role MUST have view-only access to payment information.
- **FR-011a**: System MUST allow customers to re-upload a new payment screenshot on a rejected InstaPay order. The order transitions from "rejected" back to "pending verification" upon re-upload.
- **FR-012**: System MUST prevent admins from manually changing payment status for automated payment methods (Card, Wallet, Kiosk). Only the payment processor webhook and reconciliation process may update these.
- **FR-013**: System MUST prevent clients from writing ANY payment-related fields (`paymentStatus`, `paymentMethod`, `paymobOrderId`, `paymobTransactionId`, `paymentScreenshot`, `paymentVerifiedBy`, `paymentVerifiedAt`, `paymentRejectionReason`) through direct Firestore writes. All payment fields MUST be set exclusively by Cloud Functions using the Admin SDK. Firestore security rules MUST reject any client attempt to write these fields.
- **FR-014**: System MUST schedule a per-order delayed reconciliation check (~10 minutes after order creation) via Google Cloud Tasks. This check verifies the specific order's payment status with the payment processor and updates the order accordingly. A daily scheduled Cloud Function safety sweep MUST also run to catch any orders missed by per-order checks.
- **FR-015**: The daily safety sweep MUST expire stale unpaid orders: 24 hours for card/wallet, 72 hours for kiosk, 72 hours for unverified InstaPay. It MUST also reconcile any "awaiting payment" orders older than 10 minutes that were not resolved by the per-order check.
- **FR-016**: System MUST detect double payments (two successful payment confirmations for the same order) and log a critical alert without double-processing.
- **FR-017**: System MUST display payment method and payment status on order cards in both the customer's order history and the admin dashboard.
- **FR-018**: System MUST maintain full backward compatibility with existing Cash on Delivery orders. Old orders without payment fields must load correctly with default values.
- **FR-019**: System MUST allow admins with `superAdmin` or `admin` role to configure InstaPay settings (enable/disable, phone number, payment link, custom instructions) from the admin dashboard. The `cs` role MUST NOT access payment configuration.
- **FR-019a**: System MUST allow admins with `superAdmin` or `admin` role to individually enable or disable each payment method (Card, Wallet, Kiosk/Fawry, InstaPay) from the admin storeConfig. Disabled methods MUST NOT appear in the customer's checkout payment selector. COD is always enabled.
- **FR-020**: System MUST display localized payment method names and status labels in both Arabic and English.
- **FR-021**: System MUST store all Paymob credentials (API key, HMAC secret, integration IDs) in Cloud Functions environment config or Firebase Secret Manager — never in Firestore or client-accessible locations. System MUST validate that all required credentials are present on Cloud Functions deployment or first invocation and log critical errors for any missing credentials.
- **FR-022**: *(Consolidated into FR-023 — kiosk `expired → paid` is part of the state machine allow-list.)*
- **FR-023**: System MUST enforce an explicit payment status state machine per payment method. Valid transitions: COD: `pending → paid`. Card/Wallet: `awaitingPayment → paid | failed | expired`. Kiosk: `awaitingPayment → paid | expired`, `expired → paid`. InstaPay: `pendingVerification → paid | rejected`, `rejected → pendingVerification`. All methods: any non-terminal status → `voided`. Any transition not in this allow-list MUST be rejected by Cloud Functions and Firestore security rules.
- **FR-024**: System MUST implement webhook replay protection by storing each processed webhook's transaction ID. Any webhook with a previously-seen transaction ID MUST be rejected (HTTP 200 response to prevent retries, but no data changes). The idempotency check MUST be performed atomically within the same Firestore transaction as the payment status update.
- **FR-025**: System MUST route all cart mutations (add, update quantity, remove) through Cloud Functions to maintain price integrity. When a customer adds a product to their cart, the addToCart CF fetches the current product price from the `products` collection and writes it to the cart item. updateCartQuantity and removeFromCart CFs handle quantity changes and removal. Firestore security rules MUST prevent clients from writing cart items directly. At order creation, the createPaymentIntention CF uses these server-locked cart prices as the authoritative source for order totals and payment amounts.
- **FR-026**: System MUST audit-log all payment state changes to the existing `auditLogs` Firestore collection. Logged events: webhook payment confirmation/failure, admin InstaPay verify/reject, reconciliation status updates, expired-order cleanup. Each audit entry MUST include: `orderId`, `action` (e.g., `payment.webhook.confirmed`, `payment.admin.rejected`), `actor` (`system` for automated, admin UID for manual), `before` and `after` payment status, `timestamp`, and additional context (rejection reason, transaction ID, etc.).
- **FR-027**: System MUST rate-limit the payment webhook endpoint to a maximum of 100 requests per minute per source IP. Requests exceeding the limit MUST be logged and dropped before HMAC signature processing to minimize Cloud Functions compute cost from DoS attempts.
- **FR-028**: System MUST prominently highlight orders with `pendingVerification` payment status in the admin orders list (via badge count, filter tab, or visual indicator) so admins can quickly identify orders requiring InstaPay verification.

### Key Entities

- **PaymentMethod**: Represents the payment channel chosen by the customer. Values: Cash on Delivery, Credit Card, Mobile Wallet, Kiosk/Fawry, InstaPay.
- **PaymentStatus**: Represents the current state of a payment. Values: Pending (COD default), Awaiting Payment, Pending Verification (InstaPay), Paid, Failed, Expired, Rejected, Refunded, Voided. Terminal statuses (no further transitions except voided): Paid, Failed, Refunded, Voided. Non-terminal: Pending, Awaiting Payment, Pending Verification, Expired (kiosk can recover), Rejected (InstaPay can re-upload).
- **Order** (updated): Extended with payment method, payment status, payment processor order reference, payment processor transaction reference, and payment screenshot URL (Firebase Storage download URL for InstaPay orders, null for other methods).
- **PaymentIntentionResult**: The result of initiating an online payment — contains the data needed to redirect the customer to the hosted payment page (or InstaPay instructions).
- **Payment Configuration**: Store-level settings controlling payment method availability. Each method (Card, Wallet, Kiosk/Fawry, InstaPay) has an individual enable/disable toggle. InstaPay additionally has: phone number, payment link, and custom instructions text. COD is always enabled.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Customers can complete an online card payment from checkout to confirmation in under 3 minutes (excluding time spent on the hosted payment page).
- **SC-002**: 100% of existing Cash on Delivery orders load and display correctly after the feature is deployed, with no data migration required.
- **SC-003**: Admins can verify an InstaPay payment (view screenshot, confirm or reject) in under 30 seconds from opening the order.
- **SC-004**: 99% of payment webhooks are processed and order statuses updated within 10 seconds of the payment event.
- **SC-005**: The reconciliation process catches 100% of lost webhooks within 30 minutes of the payment event, preventing revenue loss.
- **SC-006**: 0% of fraudulent payment status changes succeed — all direct client attempts to set "paid" status are blocked.
- **SC-007**: All user-facing payment labels and statuses display correctly in both Arabic and English.
- **SC-008**: The payment return page shows authoritative payment status within 30 seconds of the customer being redirected back, with a clear loading state during verification.
- **SC-009**: The system supports all five payment methods without any degradation to the existing checkout experience for COD customers.

## Assumptions

- The store already has an active account with the payment processor (Paymob) and has obtained test and production credentials.
- The existing order fulfillment flow (inventory deduction, status transitions) is triggered by order status changes and will work correctly when an online-paid order transitions to the processing status.
- The store's hosting supports redirecting customers to external payment pages and receiving them back via configurable return URLs.
- Customers using InstaPay have access to a banking app that can perform InstaPay transfers and capture screenshots.
- The admin dashboard is used by a small number of trusted operators who will review InstaPay payments in a timely manner.
- The store primarily serves Egyptian customers, so the payment currency is Egyptian Pounds (EGP) and the payment methods are Egypt-specific (Fawry, Vodafone Cash, Orange Cash, InstaPay).
- Payment processor webhook delivery is generally reliable but not guaranteed — hence the need for reconciliation.
- The existing Cloud Functions infrastructure and Firebase environment are available for deploying new server-side functions.
- Customer notifications (email, SMS, push) for payment status changes are out of scope for this feature. Customers rely on checking their order history for updates.
