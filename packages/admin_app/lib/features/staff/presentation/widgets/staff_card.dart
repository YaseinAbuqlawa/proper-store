import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart';
import 'package:admin/features/staff/presentation/widgets/change_password_dialog.dart';
import 'package:admin/features/staff/presentation/widgets/change_role_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class StaffCard extends StatefulWidget {
  final StaffListItem item;

  const StaffCard({super.key, required this.item});

  @override
  State<StaffCard> createState() => _StaffCardState();
}

class _StaffCardState extends State<StaffCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final date = widget.item.createdAt;
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.blackDeep.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: AppColors.textSubtle,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.item.username,
                    style: AppTextStyles.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _RoleBadge(role: widget.item.role.name),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${l.staffCreatedAtLabel}: $dateStr',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: AppColors.textSubtle,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Row(
              children: [
                Expanded(
                  child: _CardButton(
                    label: l.changeRoleBtn,
                    backgroundColor: AppColors.goldRoyal,
                    foregroundColor: AppColors.blackDeep,
                    onPressed: () => _showChangeRoleDialog(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.small + 4),
                Expanded(
                  child: _CardButton(
                    label: l.changePasswordBtn,
                    backgroundColor: AppColors.lightBackground,
                    foregroundColor: AppColors.textPrimary,
                    border: BorderSide(
                      color: AppColors.textSubtle.withValues(alpha: 0.25),
                    ),
                    onPressed: () => _showChangePasswordDialog(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.small + 4),
                _CardButton(
                  label: l.deleteStaffBtn,
                  backgroundColor: AppColors.lightRed,
                  foregroundColor: AppColors.whiteColor,
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeRoleDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<StaffCubit>(),
        child: ChangeRoleDialog(item: widget.item),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<StaffCubit>(),
        child: ChangePasswordDialog(item: widget.item),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final s = S.of(context);
    final currentUid = context.read<AuthCubit>().state.whenOrNull(
      authenticated: (user) => user.uid,
    );
    if (currentUid != null && widget.item.uid == currentUid) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(s.deleteStaffBtn),
          content: Text(s.cannotDeleteYourself),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(s.cancelBtn),
            ),
          ],
        ),
      );
      return;
    }
    if (widget.item.role == StaffRole.superAdmin) {
      final items =
          context.read<StaffCubit>().state.whenOrNull(
            loaded: (items) => items,
          ) ??
          const [];
      final superAdminCount = items
          .where((i) => i.role == StaffRole.superAdmin)
          .length;
      if (superAdminCount <= 1) {
        showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(s.deleteStaffBtn),
            content: Text(s.cannotDeleteLastSuperAdmin),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(s.cancelBtn),
              ),
            ],
          ),
        );
        return;
      }
    }
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.deleteStaffBtn),
        content: Text(s.deleteStaffConfirm),
        actions: [
          AdminButton.secondary(
            onPressed: () => Navigator.of(dialogContext).pop(),
            label: s.cancelBtn,
          ),
          AdminButton.primary(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<StaffCubit>().deleteStaff(widget.item.uid);
            },
            label: s.deleteStaffBtn,
          ),
        ],
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;

  const _RoleBadge({required this.role});

  Color get _color {
    switch (role) {
      case 'superAdmin':
        return AppColors.goldRoyal;
      case 'admin':
        return Colors.blue;
      default:
        return AppColors.textSubtle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _color,
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? border;
  final VoidCallback onPressed;

  const _CardButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border ?? BorderSide.none,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        minimumSize: const Size(0, 44),
      ),
      child: Text(label),
    );
  }
}
