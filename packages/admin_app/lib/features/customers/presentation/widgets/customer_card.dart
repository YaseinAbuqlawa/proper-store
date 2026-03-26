import 'package:admin/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/customer_model.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 700;
    final l = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        border: Border.all(color: const Color(0x0F000000)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: isDesktop
            ? _DesktopLayout(customer: customer, l: l)
            : _MobileLayout(customer: customer, l: l),
      ),
    );
  }
}

// ── Layouts ───────────────────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final CustomerModel customer;
  final S l;

  const _DesktopLayout({required this.customer, required this.l});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CustomerAvatar(customer: customer),
        const SizedBox(width: AppSpacing.large),
        Expanded(child: _CustomerInfo(customer: customer)),
        const SizedBox(width: AppSpacing.large),
        _ActionButtons(customer: customer, l: l),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final CustomerModel customer;
  final S l;

  const _MobileLayout({required this.customer, required this.l});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _CustomerAvatar(customer: customer),
            const SizedBox(width: AppSpacing.medium),
            Expanded(child: _CustomerInfo(customer: customer)),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        _ActionButtons(customer: customer, l: l, fullWidth: true),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _CustomerAvatar extends StatelessWidget {
  final CustomerModel customer;

  const _CustomerAvatar({required this.customer});

  @override
  Widget build(BuildContext context) {
    if (customer.photoUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          customer.photoUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _InitialsAvatar(customer: customer),
        ),
      );
    }
    return _InitialsAvatar(customer: customer);
  }
}

class _InitialsAvatar extends StatelessWidget {
  final CustomerModel customer;

  const _InitialsAvatar({required this.customer});

  @override
  Widget build(BuildContext context) {
    final initial =
        customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?';

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.goldGradient,
        border: Border.all(
          color: AppColors.goldMuted.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.blackDeep,
          ),
        ),
      ),
    );
  }
}

// ── Info ──────────────────────────────────────────────────────────────────────

class _CustomerInfo extends StatelessWidget {
  final CustomerModel customer;

  const _CustomerInfo({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customer.name,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (customer.email.isNotEmpty) ...[
          const SizedBox(height: 4),
          _InfoRow(
            icon: Icons.email_outlined,
            label: customer.email,
          ),
        ],
        if (customer.phone.isNotEmpty) ...[
          const SizedBox(height: 4),
          _InfoRow(
            icon: Icons.phone_outlined,
            label: customer.phone,
          ),
        ],
        if (customer.favoritesList.isNotEmpty) ...[
          const SizedBox(height: 4),
          _InfoRow(
            icon: Icons.favorite_border_rounded,
            label: '${customer.favoritesList.length}',
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.goldMuted),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: AppColors.textSubtle,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ── Action Buttons ────────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final CustomerModel customer;
  final S l;
  final bool fullWidth;

  const _ActionButtons({
    required this.customer,
    required this.l,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      _OutlinedBtn(
        icon: Icons.favorite_border_rounded,
        label: l.customerFavoritesTitle,
        onPressed: customer.favoritesList.isNotEmpty
            ? () => context.push(
                  AppRoutes.customerFavorites.path,
                  extra: customer,
                )
            : null,
      ),
      const SizedBox(width: AppSpacing.small, height: AppSpacing.small),
      _OutlinedBtn(
        icon: Icons.receipt_long_outlined,
        label: l.viewOrdersBtn,
        onPressed: () =>
            context.push(AppRoutes.customerOrders.path, extra: customer),
      ),
    ];

    if (fullWidth) {
      return Column(
        children: buttons.map((b) {
          if (b is _OutlinedBtn) {
            return SizedBox(width: double.infinity, child: b);
          }
          return b;
        }).toList(),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, children: buttons);
  }
}

class _OutlinedBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _OutlinedBtn({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.goldMuted,
        side: const BorderSide(color: AppColors.goldMuted),
        disabledForegroundColor: AppColors.textSubtle,
        disabledMouseCursor: SystemMouseCursors.forbidden,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
