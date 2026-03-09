import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/base_screen/widgets/bottom_nav_bar_cart_button.dart';
import 'package:proper_store/core/base_screen/widgets/bottom_nav_bar_item.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  const BaseScreen({super.key, required this.child});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  static const _routes = [
    AppRoutes.home,
    AppRoutes.favorites,
    AppRoutes.cart,
    AppRoutes.orders,
    AppRoutes.profile,
  ];

  int _indexFromPath(String path) {
    if (path.startsWith(AppRoutes.orders.path)) return 3;
    if (path.startsWith(AppRoutes.cart.path)) return 2;
    if (path.startsWith(AppRoutes.favorites.path)) return 1;
    if (path.startsWith(AppRoutes.profile.path) ||
        path.startsWith(AppRoutes.addresses.path) ||
        path.startsWith(AppRoutes.addAddress.path))
      return 4;
    return 0;
  }

  void _onItemTapped(int index, int currentIndex) {
    if (currentIndex == index) return;

    if (index == 2) {
      appRouter.push(_routes[index].path);
    } else {
      appRouter.go(_routes[index].path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final selectedIndex = _indexFromPath(GoRouterState.of(context).uri.path);
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) => state.whenOrNull(
        loaded: (customer) {
          if (customer.favoritesList.isNotEmpty) {
            context.read<FavoritesCubit>().getFavoriteProducts(
              favoritesList: customer.favoritesList,
            );
          }
          return null;
        },
      ),
      child: Scaffold(
        extendBody: true,
        body: widget.child,
        bottomNavigationBar: _BottomBar(
          selectedIndex: selectedIndex,
          onTap: (index) => _onItemTapped(index, selectedIndex),
          labels: [
            s.homeButtonName,
            s.ordersTitle,
            s.favoritesTitle,
            s.profileTitle,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BottomNavBarCartButton(
          onTap: () => _onItemTapped(2, selectedIndex),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<String> labels;

  const _BottomBar({
    required this.selectedIndex,
    required this.onTap,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).cardColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavBarItem(
                    icon: Icons.home,
                    label: labels[0],
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                  BottomNavBarItem(
                    icon: Icons.favorite,
                    label: labels[2],
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavBarItem(
                    icon: Icons.receipt_long,
                    label: labels[1],
                    index: 3,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                  BottomNavBarItem(
                    icon: Icons.person,
                    label: labels[3],
                    index: 4,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
