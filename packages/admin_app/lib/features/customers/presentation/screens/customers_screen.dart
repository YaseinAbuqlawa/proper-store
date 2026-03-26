import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/router/app_routes.dart';
import 'package:admin/core/widgets/admin_search_bar.dart';
import 'package:admin/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:admin/features/customers/presentation/cubit/customers_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/customer_model.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomersCubit>()..loadCustomers(),
      child: const _CustomersView(),
    );
  }
}

class _CustomersView extends StatefulWidget {
  const _CustomersView();

  @override
  State<_CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<_CustomersView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(l.navCustomers, style: AppTextStyles.heroHeadline),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: AdminSearchBar(
              controller: _searchController,
              hintText: l.customersSearchHint,
              onChanged: context.read<CustomersCubit>().search,
            ),
          ),
        ),
      ),
      body: BlocBuilder<CustomersCubit, CustomersState>(
        builder: (context, state) {
          switch (state.status) {
            case CustomersStatus.loaded:
              return _buildContent(context, state);
            case CustomersStatus.failure:
              final message = FirebaseFailure(
                code: state.failureMessage,
              ).fromException(context: context);
              return _ErrorView(
                message: message,
                onRetry: () => context.read<CustomersCubit>().loadCustomers(),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, CustomersState state) {
    final l = S.of(context);
    final customers = state.filteredCustomers;

    if (customers.isEmpty) {
      return Center(
        child: Text(l.customersEmpty, style: AppTextStyles.sectionTitle),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<CustomersCubit>().loadCustomers(),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.medium,
              vertical: AppSpacing.large,
            ),
            itemCount: customers.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.medium),
            itemBuilder: (context, index) =>
                _CustomerCard(customer: customers[index]),
          ),
        ),
      ),
    );
  }
}

// ── Customer Card ─────────────────────────────────────────────────────────────

class _CustomerCard extends StatelessWidget {
  final CustomerModel customer;

  const _CustomerCard({required this.customer});

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
            ? _DesktopCardLayout(customer: customer, l: l)
            : _MobileCardLayout(customer: customer, l: l),
      ),
    );
  }
}

class _DesktopCardLayout extends StatelessWidget {
  final CustomerModel customer;
  final S l;

  const _DesktopCardLayout({required this.customer, required this.l});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CustomerAvatar(customer: customer),
        const SizedBox(width: AppSpacing.large),
        Expanded(child: _CustomerInfo(customer: customer)),
        const SizedBox(width: AppSpacing.large),
        _ViewOrdersButton(customer: customer, l: l),
      ],
    );
  }
}

class _MobileCardLayout extends StatelessWidget {
  final CustomerModel customer;
  final S l;

  const _MobileCardLayout({required this.customer, required this.l});

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
        SizedBox(
          width: double.infinity,
          child: _ViewOrdersButton(customer: customer, l: l),
        ),
      ],
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

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
    final initial = customer.name.isNotEmpty
        ? customer.name[0].toUpperCase()
        : '?';

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
          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                size: 14,
                color: AppColors.goldMuted,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  customer.email,
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
          ),
        ],
        if (customer.phone.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 14,
                color: AppColors.goldMuted,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  customer.phone,
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
          ),
        ],
        if (customer.favoritesList.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.favorite_border_rounded,
                size: 14,
                color: AppColors.goldMuted,
              ),
              const SizedBox(width: 4),
              Text(
                '${customer.favoritesList.length}',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: AppColors.textSubtle,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ViewOrdersButton extends StatelessWidget {
  final CustomerModel customer;
  final S l;

  const _ViewOrdersButton({required this.customer, required this.l});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () =>
          context.push(AppRoutes.customerOrders.path, extra: customer),
      icon: const Icon(Icons.receipt_long_outlined, size: 16),
      label: Text(l.viewOrdersBtn),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.goldMuted,
        side: const BorderSide(color: AppColors.goldMuted),
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

// ── Error View ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(message, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: Text(S.of(context).retryBtn)),
        ],
      ),
    );
  }
}
