import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/base_screen/screen/base_screen.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/welcome_screen.dart';
import 'package:proper_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:proper_store/features/categories/presentation/screens/categories_screen.dart';
import 'package:proper_store/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:proper_store/features/home/presentation/screens/home_screen.dart';
import 'package:proper_store/features/orders/presentation/screens/orders_screen.dart';
import 'package:proper_store/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:proper_store/features/addresses/presentation/screens/add_address_screen.dart';
import 'package:proper_store/features/addresses/presentation/screens/addresses_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/profile_screen.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  redirect: (context, state) {
    final isLoggedIn = sl<FirebaseAuth>().currentUser != null;
    final isLoggingIn = state.fullPath == AppRoutes.welcome.path;

    if (isLoggingIn && isLoggedIn) return AppRoutes.home.path;
    if (!isLoggingIn && !isLoggedIn) return AppRoutes.welcome.path;

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home.path,
          pageBuilder: (context, state) =>
              _buildTransitionPage(state: state, child: const HomeScreen()),
        ),
        GoRoute(
          path: AppRoutes.favorites.path,
          pageBuilder: (context, state) => _buildTransitionPage(
            state: state,
            child: const FavoritesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.categories.path,
          pageBuilder: (context, state) => _buildTransitionPage(
            state: state,
            child: const CategoriesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.orders.path,
          pageBuilder: (context, state) =>
              _buildTransitionPage(state: state, child: const OrdersScreen()),
        ),
        GoRoute(
          path: AppRoutes.profile.path,
          pageBuilder: (context, state) =>
              _buildTransitionPage(state: state, child: const ProfileScreen()),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.cart.path,
      pageBuilder: (context, state) =>
          _buildTransitionPage(state: state, child: const CartScreen()),
    ),
    GoRoute(
      path: AppRoutes.welcome.path,
      pageBuilder: (context, state) =>
          _buildTransitionPage(state: state, child: const WelcomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.addresses.path,
      pageBuilder: (context, state) => _buildTransitionPage(
        state: state,
        child: const AddressesScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.addAddress.path,
      pageBuilder: (context, state) => _buildTransitionPage(
        state: state,
        child: const AddAddressScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.productDetails.path,
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final imageUrl = state.extra is String ? state.extra as String : '';

        assert(
          id != null,
          'Product details route requires an [id] path parameter',
        );

        return ProductDetailsScreen(id: id ?? '', initialImageUrl: imageUrl);
      },
    ),
  ],
);

CustomTransitionPage<void> _buildTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}
