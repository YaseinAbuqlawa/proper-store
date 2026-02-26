import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/base_screen/base_screen.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/welcome_screen.dart';
import 'package:proper_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:proper_store/features/categories/presentation/screens/categories_screen.dart';
import 'package:proper_store/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:proper_store/features/home/presentation/screens/home_screen.dart';
import 'package:proper_store/features/orders/presentation/screens/orders_screen.dart';
import 'package:proper_store/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/profile_screen.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = sl<FirebaseAuth>().currentUser != null;
    final isLoggingIn = state.fullPath == AppRoutes.welcome.path;

    if (isLoggingIn) {
      if (isLoggedIn) return AppRoutes.home.path;
    } else {
      if (!isLoggedIn) return AppRoutes.welcome.path;
    }

    return null;
  },
  navigatorKey: rootNavigationKey,
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home.path,
          pageBuilder: (context, state) => _buildTransactionPage(
            state: state,
            context: context,
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.favorites.path,
          pageBuilder: (context, state) => _buildTransactionPage(
            state: state,
            context: context,
            child: FavoritesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.categories.path,
          pageBuilder: (context, state) => _buildTransactionPage(
            state: state,
            context: context,
            child: CategoriesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.profile.path,
          pageBuilder: (context, state) => _buildTransactionPage(
            state: state,
            context: context,
            child: ProfileScreen(),
          ),
        ),
      ],
    ),

    GoRoute(
      path: AppRoutes.cart.path,
      pageBuilder: (context, state) => _buildTransactionPage(
        state: state,
        context: context,
        child: CartScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.welcome.path,
      pageBuilder: (context, state) => _buildTransactionPage(
        state: state,
        context: context,
        child: WelcomeScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.orders.path,
      pageBuilder: (context, state) => _buildTransactionPage(
        state: state,
        context: context,
        child: OrdersScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.productDetails.path,
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return ProductDetailsScreen(
          id: id!,
          initialImageUrl: state.extra as String,
        );
      },
    ),
  ],
);

CustomTransitionPage _buildTransactionPage({
  required GoRouterState state,
  required BuildContext context,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}
