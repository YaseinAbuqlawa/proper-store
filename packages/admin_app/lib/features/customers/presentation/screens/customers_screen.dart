import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/widgets/admin_search_bar.dart';
import 'package:admin/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:admin/features/customers/presentation/cubit/customers_state.dart';
import 'package:admin/features/customers/presentation/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

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
                CustomerCard(customer: customers[index]),
          ),
        ),
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
