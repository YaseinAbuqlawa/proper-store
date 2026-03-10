# Proper Store

A production-ready Flutter Web e-commerce application for women's fashion — bags and shoes. Built with Clean Architecture, Firebase, and a full order lifecycle from browsing to checkout.

**Live demo:** [theproperstore.com](https://theproperstore.com)

---

## Features

- **Product discovery** — home banner, category browsing, collection filters, dynamic product grid with infinite scroll
- **Product details** — image carousel, color selection, size options, related products, hero transitions
- **Cart & checkout** — persistent cart, color-aware cart items, city-based shipping cost, COD checkout
- **Orders** — full order lifecycle (pending → confirmed → shipped → delivered), order details with status tracker
- **Auth** — email/password, Google, Facebook (redirect flow on mobile web)
- **Favorites** — toggle and persist favorites across sessions
- **Profile** — addresses CRUD, contact us, return policy
- **Dark / light theme** — persisted via SharedPreferences, toggled from profile
- **Offline detection** — non-dismissible banner on connection loss, auto-dismisses on restore
- **PWA** — installable, custom icons, web manifest

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI | Flutter Web |
| State management | Cubit / BLoC (`flutter_bloc`) |
| Navigation | `go_router` |
| Dependency injection | `get_it` + `injectable` |
| Code generation | `freezed`, `json_serializable`, `build_runner` |
| Backend | Firebase (Auth, Firestore, App Check, Analytics) |
| Images | `cached_network_image` |
| Localization | Flutter Intl — Arabic (primary) + English |

---

## Architecture

Clean Architecture with strict layer boundaries:

```
presentation  →  domain  →  data
```

- **Presentation** — screens, cubits, widgets. No business logic. Observes state, dispatches cubit actions.
- **Domain** — use cases, repository interfaces, entities. Pure Dart. No Flutter, no Firebase.
- **Data** — repository implementations, remote data sources, Firestore models.

---

## Project Structure

```
lib/
├── core/
│   ├── base_screen/          # Bottom nav shell
│   ├── design_system/        # Colors, typography, spacing, theme
│   ├── di/                   # Dependency injection (get_it + injectable)
│   ├── failures/             # Typed failure classes
│   ├── helpers/              # Extensions, snackbar, dialog, json converters
│   ├── products/             # Shared product domain + widgets (product card, filters)
│   ├── router/               # go_router setup + AppRoutes enum
│   ├── services/             # Auth orchestration, connectivity
│   ├── theme/                # ThemeCubit + persistence
│   └── widgets/              # Shared widgets (AppNetworkImage, OfflineBanner, …)
├── features/
│   ├── auth/
│   ├── cart/
│   ├── checkout/
│   ├── favorites/
│   ├── home/
│   ├── orders/
│   ├── product_details/
│   ├── products/             # Dynamic products screen with pagination
│   └── profile/
└── main.dart
```

---

## Getting Started

```bash
# 1. Clone
git clone https://github.com/your-org/proper_store.git
cd proper_store

# 2. Install dependencies
flutter pub get

# 3. Generate code (Freezed + injectable)
dart run build_runner build --delete-conflicting-outputs

# 4. Generate PWA icons
dart run flutter_launcher_icons

# 5. Run on web
flutter run -d chrome
```

---

## Screenshots

> _Coming soon_
