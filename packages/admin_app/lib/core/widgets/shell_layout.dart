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

part 'shell_layout/desktop_layout.dart';
part 'shell_layout/mobile_layout.dart';

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
