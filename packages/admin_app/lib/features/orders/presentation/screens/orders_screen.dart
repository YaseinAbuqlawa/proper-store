import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/router/app_routes.dart';
import 'package:admin/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:admin/features/orders/presentation/cubit/orders_state.dart';
import 'package:admin/features/orders/presentation/widgets/order_card.dart';
import 'package:admin/features/orders/presentation/widgets/order_status_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrdersCubit>()..loadOrders(),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  const _OrdersView();

  @override
  State<_OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<OrdersCubit>().loadMore();
    }
  }

  bool get _isDesktop => MediaQuery.sizeOf(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.navOrders, style: AppTextStyles.heroHeadline),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l.ordersSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    helperText: l.ordersSearchScopeHint,
                    isDense: false,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    filled: true,
                    fillColor: AppColors.lightBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: const BorderSide(
                        color: AppColors.goldRoyal,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
                const SizedBox(height: 8),
                const _StatusFilterRow(),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          switch (state.status) {
            case OrdersStatus.loaded:
            case OrdersStatus.loadingMore:
              return _buildContent(
                context,
                orders: state.orders,
                isLoadingMore: state.status == OrdersStatus.loadingMore,
              );
            case OrdersStatus.failure:
              final message = FirebaseFailure(
                code: state.failureMessage,
              ).fromException(context: context);
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.errorRed,
                    ),
                    const SizedBox(height: 12),
                    Text(message, style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => context.read<OrdersCubit>().loadOrders(),
                      child: Text(l.retryBtn),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required List<OrderModel> orders,
    required bool isLoadingMore,
  }) {
    final l = S.of(context);
    final filtered = _searchQuery.isEmpty
        ? orders
        : orders
              .where(
                (o) => o.id.toLowerCase().contains(_searchQuery.toLowerCase()),
              )
              .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(l.ordersEmpty, style: AppTextStyles.sectionTitle),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<OrdersCubit>().loadOrders(),
      child: _buildGrid(context, filtered, isLoadingMore),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    List<OrderModel> orders,
    bool isLoadingMore,
  ) {
    final crossAxisCount = _isDesktop ? 2 : 1;
    final itemCount = orders.length + (isLoadingMore ? 1 : 0);

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.large),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.medium,
        mainAxisSpacing: AppSpacing.medium,
        mainAxisExtent: 212,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == orders.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final order = orders[index];
        return OrderCard(
          order: order,
          onView: () => _navigateToDetails(context, order),
          onStatusSelected: (s) =>
              context.read<OrdersCubit>().updateStatus(order.id, s),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, OrderModel order) {
    context.push(AppRoutes.orderDetails.path, extra: order);
  }
}

class _StatusFilterRow extends StatelessWidget {
  const _StatusFilterRow();

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (prev, curr) => prev.activeFilter != curr.activeFilter,
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterBtn(
                label: l.allOrdersFilter,
                selected: state.activeFilter == null,
                onTap: () => cubit.filterByStatus(null),
              ),
              ...OrderStatus.values.map(
                (s) => _FilterBtn(
                  label: orderStatusLabel(l, s),
                  selected: state.activeFilter == s,
                  onTap: () => cubit.filterByStatus(s),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterBtn({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.goldRoyal : AppColors.lightBackground,
            border: selected
                ? const Border(
                    bottom: BorderSide(color: AppColors.goldMuted, width: 2),
                  )
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.blackDeep : AppColors.textSubtle,
            ),
          ),
        ),
      ),
    );
  }
}
