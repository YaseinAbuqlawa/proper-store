import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/product_model.dart';

import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/router/app_routes.dart';
import 'package:admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:admin/features/products/presentation/cubit/products_state.dart';
import 'package:admin/features/products/presentation/widgets/delete_product_dialog.dart';
import 'package:admin/features/products/presentation/widgets/product_card_mobile.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsCubit>()..loadProducts(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatefulWidget {
  const _ProductsView();

  @override
  State<_ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<_ProductsView> {
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
      context.read<ProductsCubit>().loadMore();
    }
  }

  bool get _isDesktop => MediaQuery.sizeOf(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).productsTitle,
          style: AppTextStyles.heroHeadline,
        ),
        actions: [
          if (_isDesktop)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.productsAdd.path),
                icon: const Icon(Icons.add),
                label: Text(S.of(context).productFormAddBtn),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.of(context).productsSearchHint,
                prefixIcon: const Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ),
      ),
      floatingActionButton: _isDesktop
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.productsAdd.path),
              icon: const Icon(Icons.add),
              label: Text(S.of(context).productFormAddBtn),
            ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.loaded:
              return _buildContent(
                context,
                products: state.products,
                hasMore: state.hasMore,
                isLoadingMore: false,
              );
            case ProductsStatus.loadingMore:
              return _buildContent(
                context,
                products: state.products,
                hasMore: state.hasMore,
                isLoadingMore: true,
              );
            case ProductsStatus.failure:
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
                      state.failureMessage,
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () =>
                          context.read<ProductsCubit>().loadProducts(),
                      child: Text(S.of(context).retryBtn),
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
    required List<ProductModel> products,
    required bool hasMore,
    required bool isLoadingMore,
  }) {
    final filtered = _searchQuery.isEmpty
        ? products
        : products
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_searchQuery.toLowerCase()),
              )
              .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          S.of(context).productsEmpty,
          style: AppTextStyles.sectionTitle,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<ProductsCubit>().loadProducts(),
      child: _isDesktop
          ? _buildDesktopTable(context, filtered, isLoadingMore)
          : _buildMobileList(context, filtered, isLoadingMore),
    );
  }

  Widget _buildMobileList(
    BuildContext context,
    List<ProductModel> products,
    bool isLoadingMore,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return ProductCardMobile(
          product: products[index],
          onEdit: () =>
              context.push(AppRoutes.productsEdit.path, extra: products[index]),
          onDelete: () => _confirmDelete(context, products[index]),
        );
      },
    );
  }

  Widget _buildDesktopTable(
    BuildContext context,
    List<ProductModel> products,
    bool isLoadingMore,
  ) {
    return Column(
      children: [
        Expanded(
          child: DataTable2(
            columnSpacing: 16,
            horizontalMargin: 24,
            headingRowColor: WidgetStateProperty.all(AppColors.lightBackground),
            columns: [
              DataColumn2(
                label: Text(S.of(context).productFormSectionMainImage),
                fixedWidth: 64,
              ),
              DataColumn2(
                label: Text(S.of(context).productFormFieldName),
                size: ColumnSize.L,
              ),
              DataColumn2(label: Text(S.of(context).productFormFieldCategory)),
              DataColumn2(
                label: Text(S.of(context).productFormFieldPrice),
                numeric: true,
              ),
              DataColumn2(
                label: Text(S.of(context).productFormColorStock),
                numeric: true,
              ),
              DataColumn2(
                label: Text(S.of(context).actionsLabel),
                fixedWidth: 120,
              ),
            ],
            rows: products.map((p) => _buildTableRow(context, p)).toList(),
          ),
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  DataRow2 _buildTableRow(BuildContext context, ProductModel product) {
    return DataRow2(
      cells: [
        DataCell(
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: product.mainImageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: product.mainImageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) =>
                        const Icon(Icons.image_not_supported),
                  )
                : const Icon(Icons.image_not_supported, size: 48),
          ),
        ),
        DataCell(Text(product.name, style: AppTextStyles.productName)),
        DataCell(Text(product.category, style: AppTextStyles.sectionTitle)),
        DataCell(
          Text(
            '${product.sellingPrice.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
            style: AppTextStyles.sectionTitle,
          ),
        ),
        DataCell(
          Text(
            product.totalStock.toString(),
            style: AppTextStyles.sectionTitle,
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                tooltip: S.of(context).editBtn,
                onPressed: () =>
                    context.push(AppRoutes.productsEdit.path, extra: product),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppColors.errorRed,
                ),
                tooltip: S.of(context).deleteBtn,
                onPressed: () => _confirmDelete(context, product),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, ProductModel product) {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteProductDialog(
        productName: product.name,
        onConfirm: () =>
            context.read<ProductsCubit>().deleteProduct(product.id),
      ),
    );
  }
}
