import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
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
  int _selectedIndex = 0;
  List<String> screens = [
    AppRoutes.home.path,
    AppRoutes.categories.path,
    AppRoutes.cart.path,
    AppRoutes.favorites.path,
    AppRoutes.profile.path,
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      appRouter.push(screens[index]);
    } else {
      appRouter.go(screens[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (customer) {
            if (customer.favoritesList.isNotEmpty) {
              context.read<FavoritesCubit>().getFavoriteProducts(
                favoritesList: customer.favoritesList,
              );
            }
          },
        );
      },
      child: Scaffold(
        body: widget.child,
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          color: AppColors.darkGray,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        unSelectedIcon: Icons.home_outlined,
                        selectedIcon: Icons.home,
                        S.of(context).homeButtonName,
                        0,
                      ),
                      _buildNavItem(
                        unSelectedIcon: Icons.category_outlined,
                        selectedIcon: Icons.category,
                        S.of(context).categories,
                        1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        unSelectedIcon: Icons.favorite_border,
                        selectedIcon: Icons.favorite,
                        S.of(context).favoritesTitle,
                        3,
                      ),
                      _buildNavItem(
                        unSelectedIcon: Icons.person_outline,
                        selectedIcon: Icons.person,
                        S.of(context).profileTitle,
                        4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.goldRoyal.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: AppColors.goldRoyal,
            elevation: 5,
            shape: const CircleBorder(),
            onPressed: () => _onItemTapped(2),
            child: BlocSelector<CartCubit, CartState, int>(
              selector: (state) {
                return state.products.length;
              },
              builder: (context, productsLength) {
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    if (productsLength != 0)
                      Align(
                        alignment: AlignmentGeometry.topRight,
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            color: AppColors.lightRed,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.borderRadiusFull,
                            ),
                            border: Border.all(width: 2),
                          ),
                          child: Text(
                            "$productsLength",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.buttonText.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    Icon(
                      productsLength != 0
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: AppColors.blackDeep,
                      size: 30,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    int index, {
    required IconData selectedIcon,
    required IconData unSelectedIcon,
  }) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIcon : unSelectedIcon,
            color: isSelected ? AppColors.goldRoyal : AppColors.textSecondary,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.navLabel.copyWith(
              color: isSelected ? AppColors.goldRoyal : AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
