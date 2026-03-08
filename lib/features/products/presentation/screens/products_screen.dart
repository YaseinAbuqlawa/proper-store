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
    final screenWidth = MediaQuery.of(context).size.width;
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
            loading: () => _buildGrid(
              products: List.filled(8, ProductModel.placeholder()),
              isLoading: true,
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            success: (products) {
              if (products.isEmpty) {
                return Center(child: Text(S.of(context).noProductsYet));
              }
              return _buildGrid(
                products: products,
                isLoading: false,
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
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

  Widget _buildGrid({
    required List<ProductModel> products,
    required bool isLoading,
    required int crossAxisCount,
    required double childAspectRatio,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) =>
            ProductCard(product: products[index], enableHero: !isLoading),
      ),
    );
  }
}
