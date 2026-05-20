# Research: Paymob Payment Integration

**Date**: 2026-05-19 | **Feature**: 001-paymob-payment-integration

## R1: OrderModel Extension Strategy

**Decision**: Extend the existing `OrderModel` (freezed) in `packages/shared/lib/models/order_model.dart` with new payment fields using `@Default()` for backward compatibility.

**Rationale**: The current `OrderModel` uses `@Default('COD') String paymentMethod` as a plain string. Converting to a proper `PaymentMethod` enum with `@Default(PaymentMethod.cod)` provides type safety. Adding `PaymentStatus` with `@Default(PaymentStatus.pending)` ensures all existing Firestore documents (which lack these fields) deserialize correctly without data migration.

**Alternatives considered**:
- Separate `PaymentModel` entity linked to orders — rejected: over-engineering for current scale; adds unnecessary join complexity.
- Keep `paymentMethod` as String — rejected: loses type safety; enum provides compile-time checks and exhaustive switch statements.

## R2: Cloud Function Architecture for Payment Intentions

**Decision**: Create a new callable Cloud Function `createPaymentIntention` that handles order creation + Paymob API call atomically. Separate from existing `createOrder` function.

**Rationale**: The existing `createOrder` function handles COD-specific logic (immediate inventory deduction, stats updates). Payment orders need fundamentally different behavior: create order with `awaitingPayment` status, NO inventory deduction, then call Paymob API. Mixing both flows in one function increases complexity and risk of breaking COD.

**Alternatives considered**:
- Extend existing `createOrder` with a `paymentMethod` param — rejected: COD flow includes inventory deduction which must NOT happen for payment orders. Conditional branching inside a transaction is error-prone.
- Client-side order creation + separate payment function — rejected: violates FR-003 (server-side total calculation) and creates a race condition window.

## R3: Webhook Processing Strategy

**Decision**: HTTP-triggered Cloud Function (not callable) at `/paymobWebhook` endpoint. HMAC-SHA512 verification of Paymob's callback signature. Atomic Firestore transaction for status updates.

**Rationale**: Paymob sends POST callbacks to a public URL. HMAC verification is the industry-standard authentication for payment webhooks. Atomic transactions prevent race conditions between webhook delivery and user return page checks.

**Alternatives considered**:
- Pub/Sub intermediate — rejected: unnecessary indirection for single-source webhook; adds latency without benefit at this scale.

## R4: Payment Return Page Authentication

**Decision**: The `/payment-result` route is publicly accessible (no auth guard). If the user is authenticated, show full order details from Firestore listener. If not authenticated (session expired during Paymob checkout), show provisional status from URL params with a prompt to log in.

**Rationale**: The user's Firebase auth token may expire during the time spent on Paymob's hosted checkout page. Blocking the return page behind auth would show an error instead of payment confirmation — very poor UX. The webhook updates the order independently of the return page, so the order is safe regardless.

**Alternatives considered**:
- Force re-authentication on return — rejected: adds friction at the worst possible moment (user just paid and wants confirmation).
- Trust URL params alone — rejected: URL params can be spoofed; Firestore is the source of truth.

## R5: InstaPay Screenshot Upload Strategy

> **⚠️ SUPERSEDED (2026-05-20)**: Session 2026-05-20 clarification established that ALL payment fields are client-write-protected (FR-013). The client CANNOT update `paymentScreenshot` or `paymentStatus` directly. The revised approach uses an `uploadInstapayScreenshot` callable Cloud Function (see tasks.md T038).

**Original Decision** ~~(invalidated)~~: ~~Use `file_picker` package for selecting images. Upload to Firebase Storage. Client updates order doc with download URL and transitions `paymentStatus` to `pendingVerification`.~~

**Revised Decision**: Use `file_picker`/`image_picker` for file selection on the client. Upload to Firebase Storage at `instapay-screenshots/{orderId}/`. Then call `uploadInstapayScreenshot` Cloud Function which atomically updates the order's `paymentScreenshot` URL and transitions `paymentStatus` to `pendingVerification` server-side.

**Rationale**: All payment field writes must go through Cloud Functions (Admin SDK) per FR-013/FR-025 security model. Client handles file upload to Storage (secured by Storage rules: owner upload only, admin read only), but the Firestore order document update is server-side only.

**Alternatives considered**:
- Cloud Function handles both upload AND Firestore update — rejected: Storage upload from client is simpler and leverages Storage security rules directly.
- Base64 in Firestore — rejected: images can be 5MB; Firestore has 1MB document limit.

## R6: Cart Clearing Timing

**Decision**: Cart is cleared ONLY after payment is confirmed as "paid" (via Firestore listener on payment return page or order history). For COD, existing behavior (clear after order creation) is preserved.

**Rationale**: If cart is cleared before payment and the payment fails/expires, the customer loses their cart contents and must re-add items — unacceptable UX. For Paymob payments, the cart clear happens when the return page detects `paymentStatus: paid`. For InstaPay, the cart clear happens when the customer sees `paymentStatus: paid` (after admin confirmation).

**Alternatives considered**:
- Clear on pending order creation — rejected per clarification session.
- Clear on redirect — rejected: payment might fail after redirect.

## R7: Payment Method Availability Configuration

**Decision**: Each payment method (card, wallet, kiosk, instapay) has an individual boolean enable/disable toggle in `storeConfig`. COD is always enabled (no toggle). The checkout UI reads these flags to determine which methods to display.

**Rationale**: Gives store operators the ability to disable a broken or unwanted payment method without code changes. Per-method granularity handles the common case where one integration has issues but others work fine.

**Alternatives considered**:
- Single "online payments enabled" toggle — rejected: too coarse; can't disable kiosk while keeping card.
- No toggles (always show all configured methods) — rejected per clarification session.

## R8: Existing Cloud Functions Integration Points

**Decision**: The existing `createOrder` function deducts inventory atomically within the same transaction that creates the order. The new payment flow must NOT call `createOrder` for Paymob/InstaPay orders. Instead, `createPaymentIntention` creates the order with `orderStatus: awaitingPayment`. When the webhook confirms payment, it sets `orderStatus: pending`, which is the trigger that the existing `updateOrderStatus` function recognizes.

**Rationale**: The existing inventory deduction is tightly coupled to order creation in `createOrder`. Decoupling it would risk breaking COD. Instead, we create a parallel entry point for payment orders that only triggers inventory deduction when payment is confirmed.

**Alternatives considered**:
- Refactor `createOrder` to separate inventory logic — rejected: violates "minimal safe changes" principle; high risk to existing flow.

## R9: New Package Assessment

**Decision**: `image_picker` or `file_picker` for InstaPay screenshot selection (if not already present). No other new packages needed.

**Rationale**: Firebase Storage, Cloud Functions callable, Firestore listeners are all already available via existing Firebase packages. `fpdart` provides Either for error handling. `cached_network_image` handles screenshot display in admin. The only missing capability is image file selection for screenshots.

**Alternatives considered**:
- `dart:html` file input — possible for web-only but `image_picker`/`file_picker` is cross-platform and follows the project's existing patterns.
