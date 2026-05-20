# Implementation Plan: Paymob Payment Integration & InstaPay Manual Payment

**Branch**: `001-paymob-payment-integration` | **Date**: 2026-05-19 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/001-paymob-payment-integration/spec.md`

## Summary

Add five payment methods (COD, Card, Wallet, Kiosk, InstaPay) to the Proper Store checkout flow. Card/Wallet/Kiosk payments use Paymob's hosted checkout via Cloud Functions that create payment intentions and process webhooks. InstaPay is a manual transfer flow with screenshot upload and admin verification. The existing COD flow remains untouched. New Cloud Functions handle payment creation, webhook processing, reconciliation, and cleanup. Security is enforced via HMAC webhook verification, Firestore rules blocking client-side payment status manipulation, and atomic transactions preventing race conditions.

## Technical Context

**Language/Version**: Dart (null-safe, Flutter 3.x) + TypeScript (Node 20, Cloud Functions)

**Primary Dependencies**: Flutter, flutter_bloc, freezed, json_serializable, injectable, get_it, go_router, fpdart, firebase_core, cloud_firestore, firebase_auth, cloud_functions, firebase_storage, cached_network_image

**Storage**: Firebase Firestore (orders, storeConfig, customers), Firebase Storage (payment screenshots)

**Testing**: Flutter test (unit + widget), manual E2E testing with Paymob test credentials

**Target Platform**: Flutter Web (primary), iOS/Android (secondary)

**Project Type**: E-commerce monorepo — `packages/store_app/`, `packages/admin_app/`, `packages/shared/`, `functions/`

**Performance Goals**: Payment intention creation < 5s, webhook processing < 10s, return page verification < 30s

**Constraints**: EGP currency only, Paymob Egypt endpoints, backward compatibility with existing COD orders (no data migration), cart preserved until payment confirmed

**Scale/Scope**: Small-medium store, single-digit concurrent payments expected

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Clean Architecture | PASS | New payment feature follows presentation → domain → data. PaymentRepository interface in domain, impl in data. CheckoutCubit extended via use cases only. |
| II. Minimal & Safe Changes | PASS | Extending existing CheckoutCubit/OrderModel rather than replacing. COD flow untouched. Backward-compatible defaults on new fields. |
| III. Performance-Conscious Flutter | PASS | No heavy work in build(). Firestore listener for real-time status (efficient). Payment method selector is simple widget composition. |
| IV. Security by Default | PASS | HMAC webhook verification. Firestore rules block client payment status writes. Server-side total calculation. No hardcoded secrets (env vars). |
| V. Testing Discipline | PASS | Unit tests for payment domain/data layer. Widget tests for payment method selector and return page states. |
| VI. Clean Code & Conventions | PASS | Following existing patterns: freezed models, injectable DI, snake_case files, PascalCase classes. Shared code in shared package. |
| VII. Principled Dependencies | PASS | No new packages needed. firebase_storage already in project for other features. image_picker may be needed for screenshot upload — justified and production-grade. |

**Gate result: PASS — all principles satisfied. Proceeding to Phase 0.**

## Project Structure

### Documentation (this feature)

```text
specs/001-paymob-payment-integration/
├── plan.md              # This file
├── spec.md              # Feature specification
├── research.md          # Phase 0: research findings
├── data-model.md        # Phase 1: entity/state definitions
├── quickstart.md        # Phase 1: dev setup guide
├── contracts/           # Phase 1: Cloud Function contracts
│   ├── create-payment-intention.md
│   ├── paymob-webhook.md
│   ├── confirm-instapay-payment.md
│   ├── reconcile-payments.md
│   └── cleanup-expired-orders.md
└── tasks.md             # Phase 2: task breakdown (via /speckit-tasks)
```

### Source Code (repository root)

```text
packages/shared/lib/
├── models/
│   ├── order_model.dart              # MODIFY: add payment fields
│   ├── payment_method.dart           # NEW: PaymentMethod enum
│   ├── payment_status.dart           # NEW: PaymentStatus enum
│   └── payment_config_model.dart     # NEW: payment config from storeConfig
├── failures/
│   └── app_failures.dart             # MODIFY: add PaymentFailure if needed
└── l10n/
    ├── intl_en.arb                   # MODIFY: add payment strings
    └── intl_ar.arb                   # MODIFY: add payment strings

packages/store_app/lib/features/checkout/
├── data/
│   ├── data_sources/
│   │   └── payment_remote_data_source.dart    # NEW
│   └── repo/
│       └── payment_repo_impl.dart             # NEW
├── domain/
│   ├── entities/
│   │   └── payment_intention_result.dart       # NEW
│   ├── repo/
│   │   └── payment_repo.dart                  # NEW
│   └── use_cases/
│       └── create_payment_intention_use_case.dart  # NEW
└── presentation/
    ├── cubit/
    │   ├── checkout_cubit.dart                # MODIFY: add payment states/methods
    │   └── checkout_state.dart                # MODIFY: add payment states
    ├── screens/
    │   ├── checkout_screen.dart               # MODIFY: add payment selector
    │   ├── payment_result_screen.dart         # NEW: post-redirect verification
    │   └── instapay_instructions_screen.dart  # NEW: InstaPay transfer flow
    └── widgets/
        └── payment_method_selector.dart       # NEW

packages/store_app/lib/features/orders/
└── presentation/
    └── widgets/
        └── order_card.dart                    # MODIFY: show payment method/status

packages/admin_app/lib/features/orders/
└── presentation/
    ├── widgets/
    │   ├── order_card.dart                    # MODIFY: payment indicators
    │   └── instapay_verification_widget.dart  # NEW
    └── screens/
        └── order_details_screen.dart          # MODIFY: payment info + verification

packages/admin_app/lib/features/store_config/
├── data/                                      # MODIFY: payment config fields
├── domain/
│   └── entities/
│       └── store_config_data.dart             # MODIFY: payment toggles
└── presentation/
    └── widgets/
        └── payment_config_section.dart        # NEW

functions/src/
├── index.ts                                   # MODIFY: export new functions
├── payments.ts                                # NEW: createPaymentIntention, paymobWebhook
├── payment-helpers.ts                         # NEW: HMAC, audit logging, state machine, rate limiter, credentials
├── paymob-client.ts                           # NEW: Paymob API client (create intention, retrieve order)
├── cart.ts                                    # NEW: addToCart, updateCartQuantity, removeFromCart (FR-025)
├── payment-scheduled.ts                       # NEW: reconcilePayments, cleanupExpiredOrders
└── instapay.ts                                # NEW: confirmInstapayPayment, uploadInstapayScreenshot

packages/store_app/lib/features/cart/
├── data/
│   └── data_sources/
│       └── cart_remote_data_source.dart        # MODIFY: call CFs instead of direct Firestore writes
└── ...

packages/store_app/firestore.rules             # MODIFY: payment field + cart price guards
storage.rules                                  # MODIFY: instapay-screenshots path rules
```

**Structure Decision**: Follows existing monorepo conventions. Payment data/domain/presentation lives inside the existing `checkout` feature (extending, not duplicating). Shared models (enums, payment config) go in `packages/shared/lib/models/`. Cloud Functions get dedicated payment files alongside existing `orders.ts`.

## Complexity Tracking

No constitution violations — this table is empty.
