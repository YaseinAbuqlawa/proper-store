# Tasks: Paymob Payment Integration & InstaPay Manual Payment

**Input**: Design documents from `/specs/001-paymob-payment-integration/`

**Prerequisites**: plan.md, spec.md, data-model.md, contracts/, research.md, quickstart.md

**Tests**: Unit tests for domain/data layer logic and widget tests for critical UI flows (per constitution §V). Manual E2E testing with Paymob test credentials (see quickstart.md).

**Organization**: Tasks grouped by user story. US7 (Security) is woven into Foundational (Phase 2) and US1 (Phase 3) since security is architecturally foundational.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Shared models**: `packages/shared/lib/models/`
- **Store app**: `packages/store_app/lib/`
- **Admin app**: `packages/admin_app/lib/`
- **Cloud Functions**: `functions/src/`
- **Security rules**: `firestore.rules`, `storage.rules`

---

## Phase 1: Setup (Shared Models & Configuration)

**Purpose**: Create shared payment enums, models, and extend OrderModel with payment fields. All downstream phases depend on these.

- [ ] T001 [P] Create PaymentMethod enum with Firestore string serialization via @JsonKey converters in packages/shared/lib/models/payment_method.dart (values: cod, card, wallet, kiosk, instapay). CRITICAL: converter MUST handle case-insensitive deserialization — existing Firestore documents contain uppercase "COD" which must map to PaymentMethod.cod
- [ ] T002 [P] Create PaymentStatus enum with Firestore string serialization and a static `isValidTransition(PaymentMethod, PaymentStatus from, PaymentStatus to)` method encoding the full state machine in packages/shared/lib/models/payment_status.dart (values: pending, awaitingPayment, pendingVerification, paid, failed, expired, rejected, refunded, voided)
- [ ] T003 [P] Create PaymentConfigModel (freezed, json_serializable) in packages/shared/lib/models/payment_config_model.dart (fields: cardEnabled, walletEnabled, kioskEnabled, instapayEnabled, instapayPhoneNumber?, instapayPaymentLink?, instapayInstructions?)
- [ ] T004 Add awaitingPayment value to OrderStatus enum in the existing OrderStatus definition (packages/shared/)
- [ ] T005 Extend OrderModel with payment fields in packages/shared/lib/models/order_model.dart — add paymentMethod (@Default(PaymentMethod.cod)), paymentStatus (@Default(PaymentStatus.pending)), paymobOrderId (int?), paymobTransactionId (int?), paymentScreenshot (String?), paymentVerifiedBy (String?), paymentVerifiedAt (int?), paymentRejectionReason (String?) — all with @Default or nullable for backward compat
- [ ] T006 [P] Add payment i18n strings to store_app ARB files (packages/store_app/lib/l10n/intl_ar.arb and intl_en.arb) — payment method names, payment status labels, checkout UI copy, payment result page copy, InstaPay instructions copy
- [ ] T007 [P] Add payment i18n strings to admin_app ARB files — payment method names, payment status labels, verification UI copy, payment config labels
- [ ] T008 Run build_runner for shared, store_app, and admin_app packages to regenerate freezed/json_serializable/injectable output files

**Checkpoint**: Shared models compile. Existing COD orders deserialize correctly with default payment values (no data migration).

---

## Phase 2: Foundational (Blocking Prerequisites — Security-First)

**Purpose**: Security rules, Cloud Function helpers, and cart pricing infrastructure. MUST complete before any user story.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete. Security is foundational, not an afterthought.

- [ ] T009 Update Firestore security rules to block client writes on all order payment fields (paymentStatus, paymentMethod, paymobOrderId, paymobTransactionId, paymentScreenshot, paymentVerifiedBy, paymentVerifiedAt, paymentRejectionReason) and block client writes on cart item price field in firestore.rules
- [ ] T010 [P] Add Firebase Storage security rules for instapay-screenshots/{orderId}/ path — only authenticated order owner can upload (image files only, max 5 MB), only admin custom claim (superAdmin/admin role) can read — in storage.rules
- [ ] T011 Create HMAC-SHA512 webhook verification utility in functions/src/payment-helpers.ts — concatenates Paymob's 21 callback fields in exact order, compares computed hash against provided hmac query param
- [ ] T012 Create payment audit logging utility in functions/src/payment-helpers.ts — writes to auditLogs collection with orderId, action, actor, before/after paymentStatus, timestamp, and context fields
- [ ] T013 Create payment status state machine validator in functions/src/payment-helpers.ts — validates transitions per payment method matching FR-023 allow-list, rejects invalid transitions
- [ ] T014 Create webhook rate-limiting middleware in functions/src/payment-helpers.ts — uses in-memory Map to track request count per source IP (resets on cold start — acceptable for low-volume store), drops requests exceeding 100/min before HMAC processing, logs dropped requests. Note: stateless Cloud Functions lose state between instances; in-memory approach provides basic protection without external state dependency
- [ ] T015 [P] Create Paymob API client in functions/src/paymob-client.ts — createIntention(amount, currency, paymentMethod, integrationId, extras) and retrieveOrder(paymobOrderId) methods using Paymob's Intention API
- [ ] T016 Create credential validation utility in functions/src/payment-helpers.ts — validates all required Paymob config values (secret_key, public_key, hmac_secret, card/wallet/kiosk integration IDs) are present, logs critical errors for missing credentials
- [ ] T017 Implement addToCart callable Cloud Function in functions/src/cart.ts — authenticates caller, fetches current product price from products collection, writes cart item to customers/{uid}/cart with server-locked price. Also implement updateCartQuantity and removeFromCart callables in the same file
- [ ] T018 Update store_app cart data layer to call addToCart/updateCartQuantity/removeFromCart Cloud Functions instead of direct Firestore writes — modify CartRemoteDataSource and CartRepoImpl in packages/store_app/lib/features/cart/
- [ ] T019 Export new Cloud Functions (addToCart, updateCartQuantity, removeFromCart) from functions/src/index.ts

**Checkpoint**: Security rules deployed. Cart operations go through CFs. All helper utilities tested individually. Foundation ready — user story implementation can begin.

---

## Phase 3: User Story 1 + User Story 7 — Credit Card Payment + Security (Priority: P1) 🎯 MVP

**Goal**: Customer completes a credit card payment end-to-end. All security measures (HMAC, idempotency, atomic transactions, audit logging) are baked in from the start. US7 is not a separate phase — it IS how we build US1.

**Independent Test**: Complete card checkout from cart to confirmation with Paymob test card (`5123456789012346`). Verify order shows "paid" in customer history. Verify fake webhook (bad HMAC) returns 403. Verify client-side `paymentStatus: paid` write is rejected by Firestore rules.

### Cloud Functions

- [ ] T020 [US1] Implement createPaymentIntention callable Cloud Function in functions/src/payments.ts — validate auth, read cart items (server-locked prices), calculate total server-side, read shipping cost from storeConfig, cancel existing awaitingPayment orders for user, create order with orderStatus:awaitingPayment + paymentStatus:awaitingPayment, call Paymob Create Intention API (card integration ID), store paymobOrderId on order, return {orderId, clientSecret, publicKey, checkoutUrl}. For errors: rollback order to failed status. Per contract: create-payment-intention.md
- [ ] T021 [US1] Implement paymobWebhook HTTP Cloud Function in functions/src/payments.ts — rate-limit check → skip if pending=true → HMAC-SHA512 verification → environment/currency validation → locate Firestore order → idempotency check (reject duplicate transaction IDs) → double-payment guard (if order already paid and a DIFFERENT transaction succeeds, log critical alert + return 200 without changes per FR-016) → determine new status (voided > refunded > success > failed) → verify amount_cents matches order total → atomic Firestore transaction (validate state machine transition, update paymentStatus + paymobTransactionId, if paid: set orderStatus to pending) → audit log entry → return 200. Per contract: paymob-webhook.md
- [ ] T022 [US1] Export createPaymentIntention and paymobWebhook from functions/src/index.ts

### Store App — Data Layer

- [ ] T023 [P] [US1] Create PaymentRemoteDataSource in packages/store_app/lib/features/checkout/data/data_sources/payment_remote_data_source.dart — callCreatePaymentIntention(paymentMethod, addressId) method calling the CF via cloud_functions package
- [ ] T024 [P] [US1] Create PaymentIntentionResult entity (freezed) in packages/store_app/lib/features/checkout/domain/entities/payment_intention_result.dart (fields: orderId, clientSecret?, publicKey?, checkoutUrl?, paymentMethod)
- [ ] T025 [P] [US1] Create PaymentRepo interface in packages/store_app/lib/features/checkout/domain/repo/payment_repo.dart — createPaymentIntention(paymentMethod, addressId) returning Either<Failure, PaymentIntentionResult>

### Store App — Domain Layer

- [ ] T026 [US1] Create PaymentRepoImpl in packages/store_app/lib/features/checkout/data/repo/payment_repo_impl.dart — implements PaymentRepo, injects PaymentRemoteDataSource, maps exceptions to Failures
- [ ] T027 [US1] Create CreatePaymentIntentionUseCase in packages/store_app/lib/features/checkout/domain/use_cases/create_payment_intention_use_case.dart — @injectable, calls PaymentRepo.createPaymentIntention

### Store App — Presentation Layer

- [ ] T028 [US1] Create PaymentMethodSelector widget in packages/store_app/lib/features/checkout/presentation/widgets/payment_method_selector.dart — reads enabled methods from PaymentConfigModel (fetched from storeConfig), displays selectable payment method cards with localized names, COD always shown, disabled methods hidden
- [ ] T029 [US1] Extend CheckoutCubit to add payment method selection state and createPaymentIntention action in packages/store_app/lib/features/checkout/presentation/cubit/checkout_cubit.dart — new states: paymentMethodSelected, paymentCreating, paymentCreated(PaymentIntentionResult), paymentCreationFailed. Preserve existing COD flow untouched
- [ ] T030 [US1] Modify checkout_screen.dart to integrate PaymentMethodSelector widget and branch flow: COD → existing place-order, Card → call createPaymentIntention → redirect to checkoutUrl in packages/store_app/lib/features/checkout/presentation/screens/checkout_screen.dart
- [ ] T031 [US1] Create PaymentResultScreen in packages/store_app/lib/features/checkout/presentation/screens/payment_result_screen.dart — shows "Verifying..." loading state on mount, sets up Firestore listener on order document, displays success/failure/pending based on authoritative paymentStatus (ignores URL params), handles unauthenticated users (session expired during payment) per R4, clears cart only when paymentStatus is paid
- [ ] T032 [US1] Add /payment-result route to app_router.dart in packages/store_app/lib/core/router/app_router.dart (accepts orderId as path parameter, no auth guard per R4)

### Store App — Integration

- [ ] T033 [US1] Update order_card.dart in store_app to display payment method icon/label and payment status badge on order cards in packages/store_app/lib/features/orders/presentation/widgets/order_card.dart
- [ ] T034 [US1] Create GetPaymentConfigUseCase to fetch payment method availability from storeConfig/paymentConfig in packages/store_app/lib/features/checkout/domain/use_cases/get_payment_config_use_case.dart
- [ ] T035 [US1] Register all new injectable classes (PaymentRemoteDataSource, PaymentRepoImpl, CreatePaymentIntentionUseCase, GetPaymentConfigUseCase) in DI — annotate with @injectable/@lazySingleton and run build_runner for store_app

**Checkpoint**: Card payment works end-to-end. COD flow unchanged. Security rules enforced. Webhook processes payments atomically with audit logging.

### Tests for User Story 1 (Constitution §V — domain + data + widget)

- [ ] T035a [P] [US1] Unit test: PaymentStatus.isValidTransition() — test all valid transitions pass and invalid transitions are rejected, per-method coverage in packages/shared/test/models/payment_status_test.dart
- [ ] T035b [P] [US1] Unit test: PaymentMethod enum serialization — verify case-insensitive deserialization ("COD" → cod, "card" → card), round-trip JSON encoding in packages/shared/test/models/payment_method_test.dart
- [ ] T035c [P] [US1] Unit test: OrderModel backward compatibility — verify OrderModel.fromJson works with documents missing payment fields (defaults applied), verify documents with old "COD" string deserialize correctly in packages/shared/test/models/order_model_payment_test.dart
- [ ] T035d [P] [US1] Unit test: CreatePaymentIntentionUseCase — verify it delegates to repo and maps failures correctly in packages/store_app/test/features/checkout/domain/use_cases/create_payment_intention_use_case_test.dart
- [ ] T035e [P] [US1] Unit test: PaymentRepoImpl — verify it calls data source, maps exceptions to typed Failures in packages/store_app/test/features/checkout/data/repo/payment_repo_impl_test.dart
- [ ] T035f [P] [US1] Widget test: PaymentMethodSelector — verify only enabled methods shown, COD always present, selection callback fires correctly in packages/store_app/test/features/checkout/presentation/widgets/payment_method_selector_test.dart
- [ ] T035g [P] [US1] Widget test: PaymentResultScreen — verify shows loading state initially, displays success on paid status, displays failure on failed status, does not clear cart on non-paid status in packages/store_app/test/features/checkout/presentation/screens/payment_result_screen_test.dart

---

## Phase 4: User Story 2 — InstaPay Customer Flow (Priority: P2)

**Goal**: Customer selects InstaPay, views transfer instructions (phone number, link, amount), uploads payment screenshot. Order becomes "pending verification."

**Independent Test**: Select InstaPay at checkout, view instructions, upload a screenshot image, verify order appears in admin as "pending verification" with screenshot attached.

- [ ] T036 [US2] Extend createPaymentIntention CF to handle InstaPay — skip Paymob API call, create order with paymentStatus:awaitingPayment, return {orderId, paymentMethod:'instapay'} per contract in functions/src/payments.ts
- [ ] T037 [US2] Create InstapayInstructionsScreen in packages/store_app/lib/features/checkout/presentation/screens/instapay_instructions_screen.dart — displays store's InstaPay phone number, payment link (if configured), exact transfer amount, upload screenshot button (image_picker/file_picker), validates file type (image only) and size (max 5 MB), uploads to Firebase Storage at instapay-screenshots/{orderId}/, updates order paymentScreenshot URL and transitions paymentStatus to pendingVerification via a Cloud Function
- [ ] T038 [US2] Create uploadInstapayScreenshot callable Cloud Function in functions/src/instapay.ts — validates auth (order owner), validates order is InstaPay with awaitingPayment or rejected status, accepts screenshotUrl, updates paymentScreenshot and paymentStatus to pendingVerification atomically, writes audit log
- [ ] T039 [US2] Add /instapay-instructions route to app_router.dart in packages/store_app/lib/core/router/app_router.dart (accepts orderId as path parameter)
- [ ] T040 [US2] Extend CheckoutCubit to handle InstaPay flow — after createPaymentIntention returns instapay result, navigate to InstapayInstructionsScreen
- [ ] T041 [US2] Implement screenshot re-upload on rejected orders — in store_app order details screen, show upload button when paymentStatus is rejected and paymentMethod is instapay, call uploadInstapayScreenshot CF on upload
- [ ] T042 [US2] Export uploadInstapayScreenshot from functions/src/index.ts

**Checkpoint**: InstaPay customer flow testable end-to-end. Orders appear in admin as "pending verification" with screenshot.

---

## Phase 5: User Story 3 — Admin InstaPay Verification (Priority: P2)

**Goal**: Admin (superAdmin/admin role) views screenshot and confirms or rejects InstaPay payments. cs role is view-only. Payment config manageable from storeConfig.

**Independent Test**: Create an InstaPay order with screenshot, confirm from admin dashboard → verify order paid + inventory deducted. Reject → verify rejected status + reason recorded. Verify cs role cannot confirm/reject.

- [ ] T043 [US3] Implement confirmInstapayPayment callable Cloud Function in functions/src/instapay.ts — verify admin auth + role (superAdmin/admin only), read order, validate instapay + pendingVerification status, atomic transaction: confirm → set paymentStatus:paid + orderStatus:pending + paymentVerifiedBy + paymentVerifiedAt; reject → set paymentStatus:rejected + paymentRejectionReason + paymentVerifiedBy, write audit log. Per contract: confirm-instapay-payment.md
- [ ] T044 [US3] Export confirmInstapayPayment from functions/src/index.ts
- [ ] T045 [P] [US3] Create InstapayVerificationWidget in packages/admin_app/lib/features/orders/presentation/widgets/instapay_verification_widget.dart — displays payment screenshot as clickable/zoomable image (CachedNetworkImage + InteractiveViewer), Confirm Payment button (green, with confirmation dialog), Reject Payment button (red, with optional reason text field dialog), buttons hidden for cs role (check StaffRole.canVerifyPayments — add this getter to StaffRole)
- [ ] T046 [US3] Add canVerifyPayments permission getter to StaffRole enum in packages/admin_app/lib/features/auth/domain/entities/staff_role.dart — returns true for superAdmin and admin
- [ ] T047 [US3] Modify admin order_details_screen.dart to show payment info section (payment method, payment status, Paymob references) and embed InstapayVerificationWidget when order is InstaPay + pendingVerification in packages/admin_app/lib/features/orders/presentation/screens/order_details_screen.dart
- [ ] T048 [US3] Update admin order_card.dart to show payment method badge and payment status badge (highlight pendingVerification orders prominently) in packages/admin_app/lib/features/orders/presentation/widgets/order_card.dart
- [ ] T049 [P] [US3] Create PaymentConfigSection widget in packages/admin_app/lib/features/store_config/presentation/widgets/payment_config_section.dart — toggle switches for each payment method (card, wallet, kiosk, instapay), InstaPay settings fields (phone number, payment link, instructions text), save to storeConfig/paymentConfig document
- [ ] T050 [US3] Integrate PaymentConfigSection into admin store_config screen, gated behind canAccessStoreConfig permission (superAdmin/admin only) in packages/admin_app/lib/features/store_config/presentation/
- [ ] T051 [US3] Register all new admin_app injectable classes and run build_runner for admin_app

### Tests for User Story 3 (Constitution §V — domain + widget)

- [ ] T051a [P] [US3] Widget test: InstapayVerificationWidget — verify screenshot displays, confirm/reject buttons visible for admin role, buttons hidden for cs role, confirm triggers callback, reject shows reason dialog in packages/admin_app/test/features/orders/presentation/widgets/instapay_verification_widget_test.dart
- [ ] T051b [P] [US3] Unit test: StaffRole.canVerifyPayments — verify returns true for superAdmin and admin, false for cs in packages/admin_app/test/features/auth/domain/entities/staff_role_test.dart

**Checkpoint**: Full InstaPay flow testable �� customer uploads screenshot, admin verifies. Permission gates enforced.

---

## Phase 6: User Story 4 — Mobile Wallet Payment (Priority: P3)

**Goal**: Customer pays via mobile wallet (Vodafone Cash, Orange Cash). Shares card payment infrastructure — minimal incremental work.

**Independent Test**: Select Mobile Wallet at checkout, complete with test credentials (01010101010 / 123456 / 123456), verify order confirmed as paid.

- [ ] T052 [US4] Add wallet integration ID handling to createPaymentIntention in functions/src/payments.ts — when paymentMethod is 'wallet', use wallet_integration_id from config instead of card_integration_id
- [ ] T053 [US4] Verify PaymentMethodSelector displays wallet option when walletEnabled is true in storeConfig — no code change expected if PaymentMethodSelector already iterates enabled methods

**Checkpoint**: Wallet payment works end-to-end using shared card/wallet infrastructure.

---

## Phase 7: User Story 5 — Kiosk/Fawry Payment (Priority: P3)

**Goal**: Customer selects Fawry, gets reference number from hosted page, pays at kiosk asynchronously. Supports late payment recovery (expired → paid).

**Independent Test**: Select Fawry, verify hosted page shows reference number, simulate kiosk payment from Paymob dashboard, verify order updated to paid.

- [ ] T054 [US5] Add kiosk integration ID handling to createPaymentIntention in functions/src/payments.ts — when paymentMethod is 'kiosk', use kiosk_integration_id from config
- [ ] T055 [US5] Verify PaymentMethodSelector displays kiosk option when kioskEnabled is true in storeConfig
- [ ] T056 [US5] Add expired → paid transition handling for kiosk late payments in paymobWebhook in functions/src/payments.ts — when webhook confirms payment for an expired kiosk order, allow the transition and reactivate the order (set orderStatus:pending), write audit log with "kiosk late payment" context

**Checkpoint**: Kiosk payment works including late payment recovery from expired status.

---

## Phase 8: User Story 6 — Reconciliation & Cleanup (Priority: P3)

**Goal**: System automatically detects lost webhooks via per-order delayed check and daily sweep. Stale unpaid orders are expired automatically.

**Independent Test**: Create an order, simulate lost webhook, verify per-order check resolves it within ~10 minutes. Verify daily sweep expires stale orders correctly.

- [ ] T057 [US6] Implement reconcilePayments scheduled Cloud Function in functions/src/payment-scheduled.ts — queries orders where paymentStatus is awaitingPayment AND createdAt older than 10 minutes AND paymentMethod in [card, wallet, kiosk], limit 20 per run, for each: call Paymob retrieveOrder API, if transaction found + successful → update to paid atomically, if failed → update to failed, log all actions to auditLogs. Per contract: reconcile-payments.md
- [ ] T058 [US6] Implement cleanupExpiredOrders scheduled Cloud Function in functions/src/payment-scheduled.ts — expire card/wallet orders older than 24h, kiosk orders older than 72h, InstaPay pendingVerification orders older than 72h, batch updates in chunks of 500, log expired counts per category to auditLogs. Per contract: cleanup-expired-orders.md
- [ ] T059 [US6] Implement per-order delayed reconciliation check — in createPaymentIntention (functions/src/payments.ts), after successful order creation for card/wallet/kiosk, enqueue a Google Cloud Tasks task targeting the reconcilePayments function with the orderId payload, scheduled ~10 minutes after creation. Requires Cloud Tasks client library in functions/package.json
- [ ] T060 [US6] Export reconcilePayments and cleanupExpiredOrders scheduled functions from functions/src/index.ts

**Checkpoint**: Reconciliation catches lost webhooks. Cleanup expires stale orders. All actions audit-logged.

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Backward compatibility validation, localization verification, admin UX polish, final security review.

- [ ] T061 [P] Verify backward compatibility — load existing COD orders (without payment fields) in both store_app and admin_app, confirm they display correctly with default values (paymentMethod: COD, paymentStatus: pending), no crashes
- [ ] T062 [P] Verify all payment method names and status labels display correctly in Arabic and English in both apps
- [ ] T063 [P] Add pending verification order highlighting/filtering in admin orders list per FR-028 — pendingVerification orders shown prominently (badge count or filter tab) in packages/admin_app/lib/features/orders/presentation/
- [ ] T064 Run full quickstart.md verification checklist — all items must pass (createPaymentIntention returns URL, redirect works, webhook updates status, COD unchanged, screenshot uploads, admin verify/reject, security rules block client writes, fake webhook rejected)
- [ ] T065 Final security review — verify FR-013 (all payment fields write-protected), FR-023 (state machine enforced), FR-024 (replay protection), FR-025 (server-locked cart prices), FR-026 (audit logging), FR-027 (rate limiting) are all correctly implemented

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **Foundational (Phase 2)**: Depends on Phase 1 (T008 build_runner) — BLOCKS all user stories
- **US1+US7 (Phase 3)**: Depends on Phase 2 — MVP deliverable
- **US2 (Phase 4)**: Depends on Phase 3 (createPaymentIntention CF, checkout flow exist)
- **US3 (Phase 5)**: Depends on Phase 4 (InstaPay orders must exist to verify)
- **US4 (Phase 6)**: Depends on Phase 3 (shares card payment infrastructure)
- **US5 (Phase 7)**: Depends on Phase 3 (shares card payment infrastructure)
- **US6 (Phase 8)**: Depends on Phase 3 (orders with paymobOrderId must exist to reconcile)
- **Polish (Phase 9)**: Depends on all desired user stories being complete

### User Story Dependencies

- **US1+US7 (P1)**: After Phase 2 — no dependencies on other stories. MVP.
- **US2 (P2)**: After Phase 3 — uses createPaymentIntention CF + checkout flow
- **US3 (P2)**: After Phase 4 — needs InstaPay orders with screenshots to verify
- **US4 (P3)**: After Phase 3 — shares card infrastructure, can run parallel with US2/US3
- **US5 (P3)**: After Phase 3 — shares card infrastructure, can run parallel with US2/US3/US4
- **US6 (P3)**: After Phase 3 — needs payment orders to reconcile, can run parallel with US2-US5

### Within Each User Story

- Cloud Functions before client data layer
- Data layer before domain layer
- Domain layer before presentation layer
- Core implementation before integration tasks
- DI registration + build_runner at end of each phase

### Parallel Opportunities

- Phase 1: T001, T002, T003, T006, T007 can all run in parallel
- Phase 2: T010 and T015 can run in parallel (different files). T011-T014, T016 are sequential (same file: payment-helpers.ts)
- Phase 3: T023, T024, T025 can run in parallel (different files). T020+T021 are sequential (same file)
- Phase 5: T045, T049 can run in parallel (different feature areas)
- After Phase 3 completes: US4, US5, US6 can all run in parallel (independent stories)

---

## Parallel Example: Phase 2 (Foundational)

```
# T011-T016 write to the same file (payment-helpers.ts) — execute SEQUENTIALLY:
T011: "HMAC-SHA512 verification in functions/src/payment-helpers.ts"
T012: "Audit logging utility in functions/src/payment-helpers.ts"
T013: "State machine validator in functions/src/payment-helpers.ts"
T014: "Rate-limiting middleware in functions/src/payment-helpers.ts"
T016: "Credential validation in functions/src/payment-helpers.ts"

# T010 and T015 can run in PARALLEL with T011-T016 (different files):
T010: "Firebase Storage security rules in storage.rules"
T015: "Paymob API client in functions/src/paymob-client.ts"

# Then sequentially:
T017: "addToCart CF in functions/src/cart.ts" (uses helpers)
T018: "Update store_app cart data layer" (depends on T017)
```

## Parallel Example: After Phase 3 (Multiple Stories)

```
# These can run in parallel (independent stories, different files):
US4 (Phase 6): T052-T053 — Wallet payment (functions/src/payments.ts tweak)
US5 (Phase 7): T054-T056 — Kiosk payment (functions/src/payments.ts tweak)
US6 (Phase 8): T057-T060 — Reconciliation (functions/src/payment-scheduled.ts)
```

---

## Implementation Strategy

### MVP First (US1 + US7 Only)

1. Complete Phase 1: Setup (shared models)
2. Complete Phase 2: Foundational (security rules, helpers, cart pricing)
3. Complete Phase 3: US1+US7 (card payment + security)
4. **STOP and VALIDATE**: Test card payment end-to-end with Paymob test credentials
5. Deploy if ready — store can accept card payments securely

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add US1+US7 → Card payments work → Deploy (MVP!)
3. Add US2 → InstaPay customer flow works → Deploy
4. Add US3 → Admin can verify InstaPay → Deploy
5. Add US4 → Wallet payments work → Deploy
6. Add US5 → Kiosk payments work → Deploy
7. Add US6 → Reconciliation + cleanup automated → Deploy
8. Polish → Final validation → Production release

### Suggested MVP Scope

**Phase 1 + Phase 2 + Phase 3 (US1+US7)** — Card payment with full security. This alone provides significant value: revenue capture via card payments, security hardening, and backward-compatible COD.

---

## Notes

- [P] tasks = different files, no dependencies on incomplete tasks
- [Story] label maps task to specific user story for traceability
- US7 (Security) is embedded in Phase 2 + Phase 3, not a separate phase — security is how we build, not an add-on
- All Cloud Functions must write audit logs for payment state changes (FR-026)
- All payment status transitions must be validated against the state machine (FR-023)
- After any model change: run `dart run build_runner build --delete-conflicting-outputs` in affected packages
- After any Cloud Function change: run `npm run build` in functions/ and deploy with `firebase deploy --only functions`
- Paymob test credentials in quickstart.md — use for all manual E2E testing
- NEVER edit generated files (.g.dart, .freezed.dart) — only modify source files
