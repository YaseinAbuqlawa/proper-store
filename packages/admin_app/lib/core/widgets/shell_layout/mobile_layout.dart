part of '../shell_layout.dart';

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
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
