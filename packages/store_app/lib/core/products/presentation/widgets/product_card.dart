import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/products/presentation/widgets/add_to_favorite.dart';
import 'package:proper_store/core/products/presentation/widgets/product_price.dart';
import 'package:proper_store/core/products/presentation/widgets/select_color_dialog.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/app_network_image.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/core/widgets/oos_diagonal_painter.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/sizes/app_sizes.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool showAddToCart;
  final bool enableHero;
  const ProductCard({
    super.key,
    required this.product,
    this.enableHero = true,
    this.showAddToCart = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final deviceType = AppSizes.getDeviceType(screenWidth);

    final EdgeInsets cardEdge = deviceType == DeviceType.smallPhone
        ? const EdgeInsets.all(AppSpacing.extraSmall)
        : AppSpacing.cardPadding;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            appRouter.push(
              AppRoutes.productDetails.withId(product.id),
              extra: product.mainImageUrl,
            );
          },
          child: Container(
            padding: cardEdge,
            margin: cardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(
                AppSpacing.borderRadiusMedium,
              ),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    enableHero
                        ? Hero(
                            tag: product.mainImageUrl + product.id,
                            child: AppNetworkImage(
                              imageUrl: product.mainImageUrl,
                              height: constraints.maxHeight * .5,
                            ),
                          )
                        : Skeleton.replace(
                            width: double.infinity,
                            height: constraints.maxHeight * .5,
                            child: AppNetworkImage(
                              imageUrl: product.mainImageUrl,
                              height: constraints.maxHeight * .5,
                            ),
                          ),
                    AddToFavorite(
                      productId: product.id,
                      onPressed: () async {
                        await context.read<FavoritesCubit>().toggleFavorite(
                          product: product,
                        );
                      },
                    ),
                    if (product.totalStock == 0) const _OosOverlay(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const AppSpacer(height: 10),
                    Text(
                      product.name,
                      style: AppTextStyles.productName,
                      maxLines: 1,
                    ),
                    const AppSpacer(height: 10),
                    ProductPrice(
                      originalPrice: product.sellingPrice,
                      offerPrice: product.offerPrice,
                      discountPercentage: product.discountPercentage,
                    ),
                    const AppSpacer(height: 10),
                    if (product.variants.isNotEmpty && showAddToCart) ...[
                      _VariantColorsRow(product: product),
                      const AppSpacer(height: 10),
                      AddToCart(product: product),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OosOverlay extends StatelessWidget {
  const _OosOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Text(
              S.of(context).outOfStockLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VariantColorsRow extends StatelessWidget {
  final ProductModel product;
  const _VariantColorsRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final variants = product.variants;
    final count = variants.length;
    if (count == 0) return const SizedBox.shrink();
    final entries = variants.entries.toList();
    return Row(
      children: [
        _ColorCircle(
          color: entries[0].value.color,
          isOos: product.outOfStockVariants.contains(entries[0].key),
        ),
        if (count >= 2) ...[
          const SizedBox(width: 4),
          _ColorCircle(
            color: entries[1].value.color,
            isOos: product.outOfStockVariants.contains(entries[1].key),
          ),
        ],
        if (count > 2) ...[
          const SizedBox(width: 4),
          _OverflowCount(count: count - 2),
        ],
      ],
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final bool isOos;
  const _ColorCircle({required this.color, this.isOos = false});

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(width: 0.25, color: AppColors.blackDeep),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
        color: color,
      ),
    );

    if (!isOos) return circle;

    return Opacity(
      opacity: 0.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          circle,
          const SizedBox(
            width: 20,
            height: 20,
            child: CustomPaint(painter: OosDiagonalPainter()),
          ),
        ],
      ),
    );
  }
}

class _OverflowCount extends StatelessWidget {
  final int count;
  const _OverflowCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.textSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: AppTextStyles.bodyDescription.copyWith(fontSize: 8),
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  final ProductModel product;
  const AddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);
    final bool isOos = product.totalStock == 0;

    return BlocSelector<CartCubit, CartState, CartItemModel?>(
      selector: (state) =>
          state.products.where((p) => p.productId == product.id).firstOrNull,
      builder: (context, cartProduct) {
        return ElevatedButton(
          onPressed: isOos
              ? null
              : () {
                  showDialog(
                    context: context,
                    builder: (context) => SelectColorDialog(product: product),
                  );
                },
          style: ElevatedButton.styleFrom(
            padding: deviceType == DeviceType.smallPhone
                ? EdgeInsets.zero
                : const EdgeInsets.all(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Icon(Icons.shopping_cart),
                  if (cartProduct != null)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.blackDeep,
                      ),
                      child: Text(
                        cartProduct.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyDescription.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 6,
                        ),
                      ),
                    ),
                ],
              ),
              const AppSpacer(width: 10),
              Text(S.of(context).addToCartText),
            ],
          ),
        );
      },
    );
  }
}
