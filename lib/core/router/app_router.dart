import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/base_screen/base_screen.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/auth/presentation/screens/auth_screen.dart';
import 'package:proper_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:proper_store/features/categories/presentation/screens/categories_screen.dart';
import 'package:proper_store/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:proper_store/features/home/presentation/screens/home_screen.dart';
import 'package:proper_store/features/orders/presentation/screens/orders_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/profile_screen.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: AppRoutes.home.path,
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
          path: AppRoutes.cart.path,
          pageBuilder: (context, state) => _buildTransactionPage(
            state: state,
            context: context,
            child: CartScreen(),
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
      path: AppRoutes.auth.path,
      pageBuilder: (context, state) => _buildTransactionPage(
        state: state,
        context: context,
        child: AuthScreen(),
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
