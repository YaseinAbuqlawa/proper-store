import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/base_screen/screen/base_screen.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/addresses/presentation/screens/add_address_screen.dart';
import 'package:proper_store/features/addresses/presentation/screens/addresses_screen.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/welcome_screen.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:proper_store/features/categories/presentation/screens/categories_screen.dart';
import 'package:proper_store/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:proper_store/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:proper_store/features/checkout/presentation/screens/order_confirmation_screen.dart';
import 'package:proper_store/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:proper_store/features/home/presentation/screens/home_screen.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store/features/orders/presentation/screens/order_details_screen.dart';
import 'package:proper_store/features/orders/presentation/screens/orders_screen.dart';
import 'package:proper_store/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:proper_store/features/products/presentation/cubit/products_screen_cubit.dart';
import 'package:proper_store/features/products/presentation/models/products_screen_args.dart';
import 'package:proper_store/features/products/presentation/screens/products_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/contact_us_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/profile_screen.dart';
import 'package:proper_store/core/widgets/not_found_screen.dart';
import 'package:proper_store/features/profile/presentation/screens/return_policy_screen.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: AppRoutes.home.path,
  errorBuilder: (context, state) => const NotFoundScreen(),
  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  redirect: (context, state) {
    if (state.error != null) return null;

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
      pageBuilder: (context, state) =>
          _buildTransitionPage(state: state, child: const AddressesScreen()),
    ),
    GoRoute(
      path: AppRoutes.addAddress.path,
      pageBuilder: (context, state) =>
          _buildTransitionPage(state: state, child: const AddAddressScreen()),
    ),
    GoRoute(
      path: AppRoutes.checkout.path,
      redirect: (context, state) {
        final user = sl<FirebaseAuth>().currentUser;
        if (user == null || user.isAnonymous) return AppRoutes.welcome.path;
        return null;
      },
      pageBuilder: (context, state) {
        final extra = state.extra;
        final buyNowItems = extra is List<CartItemModel> ? extra : null;
        return _buildTransitionPage(
          state: state,
          child: BlocProvider(
            create: (_) => sl<CheckoutCubit>(),
            child: CheckoutScreen(buyNowItems: buyNowItems),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.orderConfirmation.path,
      builder: (context, state) {
        final orderId = state.extra is String ? state.extra as String : '';
        return OrderConfirmationScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: AppRoutes.orderDetails.path,
      redirect: (context, state) =>
          state.extra is OrderModel ? null : AppRoutes.home.path,
      builder: (context, state) {
        final order = state.extra as OrderModel;
        return OrderDetailsScreen(order: order);
      },
    ),
    GoRoute(
      path: AppRoutes.products.path,
      redirect: (context, state) =>
          state.extra is ProductsScreenArgs ? null : AppRoutes.home.path,
      builder: (context, state) {
        final args = state.extra as ProductsScreenArgs;
        return BlocProvider(
          create: (_) => sl<ProductsScreenCubit>()..loadProducts(args.filter),
          child: ProductsScreen(title: args.title),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.contactUs.path,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: AppRoutes.returnPolicy.path,
      builder: (context, state) => const ReturnPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetails.path,
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final imageUrl = state.extra is String ? state.extra as String : '';

        if (id == null || id.isEmpty) return const NotFoundScreen();

        return ProductDetailsScreen(id: id, initialImageUrl: imageUrl);
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
