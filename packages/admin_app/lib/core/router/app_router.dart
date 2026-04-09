import 'dart:async';

import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/router/app_routes.dart';
import 'package:admin/core/widgets/not_found_screen.dart';
import 'package:admin/core/widgets/shell_layout.dart';
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin/features/auth/presentation/screens/login_screen.dart';
import 'package:admin/features/customers/presentation/screens/customer_cart_screen.dart';
import 'package:admin/features/customers/presentation/screens/customer_favorites_screen.dart';
import 'package:admin/features/customers/presentation/screens/customers_screen.dart';
import 'package:admin/features/orders/presentation/screens/order_details_screen.dart';
import 'package:admin/features/orders/presentation/screens/orders_screen.dart';
import 'package:admin/features/products/presentation/screens/product_form_screen.dart';
import 'package:admin/features/products/presentation/screens/products_screen.dart';
import 'package:admin/features/reports/presentation/screens/reports_screen.dart';
import 'package:admin/features/staff/presentation/screens/staff_screen.dart';
import 'package:admin/features/store_config/presentation/screens/store_config_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store_shared/models/product_model.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: AppRoutes.orders.path,
  refreshListenable: _AuthRefreshListenable(sl<FirebaseAuth>()),
  errorBuilder: (context, state) => const NotFoundScreen(),
  redirect: (context, state) {
    if (state.error != null) return null;

    final isLoggedIn = sl<FirebaseAuth>().currentUser != null;
    final isLoggingIn = state.fullPath == AppRoutes.login.path;

    if (isLoggingIn && isLoggedIn) return AppRoutes.orders.path;
    if (!isLoggingIn && !isLoggedIn) return AppRoutes.login.path;

    if (isLoggedIn) {
      final role = sl<AuthCubit>().state.mapOrNull(
        authenticated: (s) => s.user.role,
      );
      if (role != null) {
        final path = state.fullPath ?? '';
        if (path.startsWith('/products') && !role.canAccessProducts) {
          return AppRoutes.orders.path;
        }
        if (path == AppRoutes.storeConfig.path && !role.canAccessStoreConfig) {
          return AppRoutes.orders.path;
        }
        if (path == AppRoutes.reports.path && !role.canAccessReports) {
          return AppRoutes.orders.path;
        }
        if (path == AppRoutes.staff.path && !role.canManageStaff) {
          return AppRoutes.orders.path;
        }
      }
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login.path,
      builder: (context, state) => BlocProvider.value(
        value: sl<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) => BlocProvider.value(
        value: sl<AuthCubit>(),
        child: ShellLayout(currentPath: state.matchedLocation, child: child),
      ),
      routes: [
        GoRoute(
          path: AppRoutes.orders.path,
          builder: (ctx, s) => const OrdersScreen(),
          routes: [
            GoRoute(
              path: 'details',
              builder: (_, s) =>
                  OrderDetailsScreen(order: s.extra as OrderModel),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.products.path,
          builder: (ctx, s) => const AdminProductsScreen(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (ctx, s) => const ProductFormScreen(),
            ),
            GoRoute(
              path: 'edit',
              builder: (_, state) =>
                  ProductFormScreen(product: state.extra as ProductModel?),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.customers.path,
          builder: (ctx, s) => const CustomersScreen(),
        ),
        GoRoute(
          path: AppRoutes.customerOrders.path,
          builder: (_, s) => OrdersScreen(customer: s.extra as CustomerModel),
        ),
        GoRoute(
          path: AppRoutes.customerFavorites.path,
          builder: (_, s) =>
              CustomerFavoritesScreen(customer: s.extra as CustomerModel),
        ),
        GoRoute(
          path: AppRoutes.customerCart.path,
          builder: (_, s) =>
              CustomerCartScreen(customer: s.extra as CustomerModel),
        ),
        GoRoute(
          path: AppRoutes.storeConfig.path,
          builder: (ctx, s) => const StoreConfigScreen(),
        ),
        GoRoute(
          path: AppRoutes.reports.path,
          builder: (ctx, s) => const ReportsScreen(),
        ),
        GoRoute(
          path: AppRoutes.staff.path,
          builder: (ctx, s) => const StaffScreen(),
        ),
      ],
    ),
  ],
);

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(FirebaseAuth auth) {
    _sub = auth.authStateChanges().listen((_) => notifyListeners());
  }

  late final StreamSubscription<User?> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
