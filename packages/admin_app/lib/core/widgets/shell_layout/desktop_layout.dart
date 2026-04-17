part of '../shell_layout.dart';

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
