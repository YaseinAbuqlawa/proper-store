import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
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
    appRouter.go(screens[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.blackDeep,
            size: 30,
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
