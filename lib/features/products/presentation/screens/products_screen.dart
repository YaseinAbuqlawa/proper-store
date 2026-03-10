import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/presentation/widgets/product_card.dart';
import 'package:proper_store/core/widgets/shopping_bag_button.dart';
import 'package:proper_store/features/products/presentation/cubit/products_screen_cubit.dart';
import 'package:proper_store/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsScreen extends StatelessWidget {
  final String title;

  const ProductsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final deviceType = AppSizes.getDeviceType(screenWidth);

    final (double childAspectRatio, int crossAxisCount) = switch (deviceType) {
      DeviceType.smallPhone => (4 / 6, 1),
      DeviceType.mediumPhone => (4 / 10, 2),
      DeviceType.largePhone => (3 / 7, 2),
      DeviceType.tablet => (4 / 7, 3),
      DeviceType.laptop => (4 / 8, 4),
    };

    return Scaffold(
      appBar: AppBar(title: Text(title), actions: const [ShoppingBagButton()]),
      body: BlocBuilder<ProductsScreenCubit, ProductsScreenState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildSkeletonGrid(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            paginated: (products, hasMore, isLoadingMore) {
              if (products.isEmpty) {
                return Center(child: Text(S.of(context).noProductsYet));
              }
              return _PaginatedGrid(
                products: products,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                onLoadMore: () =>
                    context.read<ProductsScreenCubit>().loadMore(),
              );
            },
            failure: (_) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  Text(S.of(context).firebase_error_unexpected),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () =>
                        context.read<ProductsScreenCubit>().retryLoad(),
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonGrid({
    required int crossAxisCount,
    required double childAspectRatio,
  }) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: 8,
        itemBuilder: (context, index) =>
            ProductCard(product: ProductModel.placeholder(), enableHero: false),
      ),
    );
  }
}

class _PaginatedGrid extends StatefulWidget {
  final List<ProductModel> products;
  final bool hasMore;
  final bool isLoadingMore;
  final int crossAxisCount;
  final double childAspectRatio;
  final VoidCallback onLoadMore;

  const _PaginatedGrid({
    required this.products,
    required this.hasMore,
    required this.isLoadingMore,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.onLoadMore,
  });

  @override
  State<_PaginatedGrid> createState() => _PaginatedGridState();
}

class _PaginatedGridState extends State<_PaginatedGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductCard(product: widget.products[index]),
              childCount: widget.products.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
            ),
          ),
        ),
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
