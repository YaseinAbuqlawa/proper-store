import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/router/app_routes.dart';
import 'package:admin/core/widgets/admin_search_bar.dart';
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
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  final CustomerModel? customer;

  const OrdersScreen({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<OrdersCubit>();
        if (customer != null) cubit.setCustomerFilter(customer!.id);
        return cubit..loadOrders();
      },
      child: _OrdersView(customer: customer),
    );
  }
}

class _OrdersView extends StatefulWidget {
  final CustomerModel? customer;

  const _OrdersView({this.customer});

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
    final customer = widget.customer;
    return Scaffold(
      appBar: AppBar(
        title: customer != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.navOrders, style: AppTextStyles.heroHeadline),
                  Text(
                    customer.name,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      color: AppColors.textSubtle,
                    ),
                  ),
                ],
              )
            : Text(l.navOrders, style: AppTextStyles.heroHeadline),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              children: [
                AdminSearchBar(
                  controller: _searchController,
                  hintText: l.ordersSearchHint,
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
                    Text(
                      state.failure!.fromException(context: context),
                      style: AppTextStyles.sectionTitle,
                    ),
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
              context.read<OrdersCubit>().updateStatus(order, s),
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
