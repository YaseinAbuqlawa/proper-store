import 'package:admin/core/router/app_routes.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const ShellLayout({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
        final isDesktop = MediaQuery.sizeOf(context).width >= 1024;

        return isDesktop
            ? _DesktopLayout(currentPath: currentPath, user: user, child: child)
            : _MobileLayout(currentPath: currentPath, user: user, child: child);
      },
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final StaffModel? user;

  const _DesktopLayout({
    required this.child,
    required this.currentPath,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _Sidebar(currentPath: currentPath, user: user),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String currentPath;
  final StaffModel? user;

  const _Sidebar({required this.currentPath, required this.user});

  @override
  Widget build(BuildContext context) {
    final items = _navItems(context, user?.role);
    return Container(
      width: 240,
      color: AppColors.blackCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SidebarHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: items.length,
              itemBuilder: (context, i) => _SidebarItem(
                item: items[i],
                selected: currentPath == items[i].route.path,
                onTap: () => context.go(items[i].route.path),
              ),
            ),
          ),
          _SidebarFooter(user: user),
        ],
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.goldRoyal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.store, color: AppColors.darkGray, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            S.of(context).dashboardTitle,
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.goldRoyal : AppColors.whiteColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected
            ? AppColors.goldRoyal.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(item.icon, size: 20, color: color),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                if (selected) ...[
                  const Spacer(),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.goldRoyal,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarFooter extends StatelessWidget {
  final StaffModel? user;

  const _SidebarFooter({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.goldRoyal,
            child: Icon(Icons.person, color: AppColors.darkGray, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user?.email ?? '',
                  style: AppTextStyles.bodyDescription.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user?.role.name.toUpperCase() ?? '',
                  style: AppTextStyles.navLabel.copyWith(
                    color: AppColors.goldRoyal,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: AppColors.whiteColor,
              size: 18,
            ),
            tooltip: S.of(context).logoutButton,
            onPressed: () => context.read<AuthCubit>().signOut(),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final StaffModel? user;

  const _MobileLayout({
    required this.child,
    required this.currentPath,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final items = _navItems(context, user?.role);
    final currentIndex = items.indexWhere((i) => i.route.path == currentPath);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          items.where((i) => i.route.path == currentPath).firstOrNull?.label ??
              S.of(context).dashboardTitle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: S.of(context).logoutButton,
            onPressed: () => context.read<AuthCubit>().signOut(),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          boxShadow: AppColors.cardShadow,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                items.length,
                (i) => _BottomNavItem(
                  item: items[i],
                  selected: i == currentIndex,
                  onTap: () => context.go(items[i].route.path),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.goldRoyal : AppColors.textSubtle;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.goldRoyal.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: AppTextStyles.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final AppRoutes route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

List<_NavItem> _navItems(BuildContext context, StaffRole? role) {
  final s = S.of(context);
  final items = <_NavItem>[
    _NavItem(
      icon: Icons.receipt_long_outlined,
      label: s.navOrders,
      route: AppRoutes.orders,
    ),
    _NavItem(
      icon: Icons.people_outline,
      label: s.navCustomers,
      route: AppRoutes.customers,
    ),
  ];

  if (role == null || role.canAccessProducts) {
    items.insert(
      1,
      _NavItem(
        icon: Icons.inventory_2_outlined,
        label: s.navProducts,
        route: AppRoutes.products,
      ),
    );
  }

  if (role == null || role.canAccessStoreConfig) {
    items.add(
      _NavItem(
        icon: Icons.settings_outlined,
        label: s.navStoreConfig,
        route: AppRoutes.storeConfig,
      ),
    );
  }

  if (role == null || role.canAccessReports) {
    items.add(
      _NavItem(
        icon: Icons.bar_chart_outlined,
        label: s.reportsTitle,
        route: AppRoutes.reports,
      ),
    );
  }

  if (role?.canManageStaff == true) {
    items.add(
      _NavItem(
        icon: Icons.manage_accounts_outlined,
        label: s.staffManagementTitle,
        route: AppRoutes.staff,
      ),
    );
  }

  return items;
}
