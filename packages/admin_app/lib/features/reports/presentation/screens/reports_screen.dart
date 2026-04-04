import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/proper_store_shared.dart';

import '../../domain/entities/out_of_stock_product.dart';
import '../cubit/reports_cubit.dart';
import '../widgets/customers_panel.dart';
import '../widgets/inventory_panel.dart';
import '../widgets/orders_panel.dart';
import '../widgets/out_of_stock_panel.dart';
import '../widgets/revenue_panel.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReportsCubit>()..loadDashboard(),
      child: const _ReportsView(),
    );
  }
}

class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(l.reportsTitle, style: AppTextStyles.heroHeadline),
      ),
      // Outer BlocBuilder handles only the top-level state variant gate
      // (initial / loading / failure / loaded). buildWhen prevents rebuilds
      // when only OOS sub-fields toggle — those are isolated below.
      body: BlocBuilder<ReportsCubit, ReportsState>(
        buildWhen: (prev, next) =>
            prev.runtimeType != next.runtimeType ||
            next.mapOrNull(reportsLoaded: (s) => s.stats) !=
                prev.mapOrNull(reportsLoaded: (s) => s.stats),
        builder: (context, state) {
          return state.when(
            reportsInitial: () => const SizedBox.shrink(),
            reportsLoading: () =>
                const Center(child: CircularProgressIndicator()),
            reportsFailure: (message) => _ErrorView(
              message: FirebaseFailure(
                code: message,
              ).fromException(context: context),
              onRetry: () => context.read<ReportsCubit>().loadDashboard(),
            ),
            reportsLoaded:
                (
                  stats,
                  outOfStockProducts,
                  isLoadingOos,
                  oosFailure,
                ) => RefreshIndicator(
                  onRefresh: () => context.read<ReportsCubit>().loadDashboard(),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppSpacing.medium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // These panels depend only on `stats`, which does not
                            // change when OOS loading toggles — they never rebuild
                            // unnecessarily.
                            RevenuePanel(stats: stats),
                            const SizedBox(height: AppSpacing.large),
                            OrdersPanel(stats: stats),
                            const SizedBox(height: AppSpacing.large),
                            CustomersPanel(stats: stats),
                            const SizedBox(height: AppSpacing.large),
                            // InventoryPanel: stat card + top-sellers (stats only).
                            InventoryPanel(stats: stats),
                            const SizedBox(height: AppSpacing.large),
                            // BlocSelector isolates OOS state changes so only
                            // OutOfStockPanel rebuilds when isLoadingOos,
                            // outOfStockProducts, or oosFailure change.
                            BlocSelector<
                              ReportsCubit,
                              ReportsState,
                              _OosState?
                            >(
                              selector: (state) => state.mapOrNull(
                                reportsLoaded: (s) => _OosState(
                                  outOfStockProducts: s.outOfStockProducts,
                                  isLoading: s.isLoadingOos,
                                  failure: s.oosFailure,
                                ),
                              ),
                              builder: (context, oos) {
                                if (oos == null) return const SizedBox.shrink();
                                return OutOfStockPanel(
                                  products: oos.outOfStockProducts,
                                  isLoading: oos.isLoading,
                                  failure: oos.failure,
                                  onRequestOos: () => context
                                      .read<ReportsCubit>()
                                      .loadOutOfStockProducts(),
                                );
                              },
                            ),
                            const SizedBox(height: AppSpacing.extraLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}

/// Lightweight value object used by the BlocSelector to carry the three OOS
/// fields. Structural equality prevents redundant OutOfStockPanel rebuilds.
class _OosState {
  final List<OutOfStockProduct> outOfStockProducts;
  final bool isLoading;
  final String? failure;

  const _OosState({
    required this.outOfStockProducts,
    required this.isLoading,
    required this.failure,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _OosState &&
          listEquals(outOfStockProducts, other.outOfStockProducts) &&
          isLoading == other.isLoading &&
          failure == other.failure;

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(outOfStockProducts), isLoading, failure);
}

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
