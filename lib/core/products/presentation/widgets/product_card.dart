import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/presentation/widgets/add_to_favorite.dart';
import 'package:proper_store/core/products/presentation/widgets/product_price.dart';
import 'package:proper_store/core/products/presentation/widgets/select_color_dialog.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/app_network_image.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            appRouter.push(
              AppRoutes.productDetails.withId(product.id),
              extra: product.imageUrls[0],
            );
          },
          child: Container(
            padding: AppSpacing.cardPadding,
            margin: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: BorderRadius.circular(
                AppSpacing.borderRadiusMedium,
              ),
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
                            tag: product.imageUrls[0] + product.id,
                            child: AppNetworkImage(
                              imageUrl: product.imageUrls[0],
                              height: constraints.maxHeight * .5,
                            ),
                          )
                        : AppNetworkImage(
                            imageUrl: product.imageUrls[0],
                            height: constraints.maxHeight * .5,
                          ),
                    AddToFavorite(
                      productId: product.id,
                      onPressed: () async {
                        await context.read<FavoritesCubit>().toggleFavorite(
                          product: product,
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppSpacer(height: 10),
                    Text(
                      product.name,
                      style: AppTextStyles.productName,
                      maxLines: 1,
                    ),
                    AppSpacer(height: 10),
                    ProductPrice(
                      originalPrice: product.sellingPrice,
                      offerPrice: product.offerPrice(),
                      discountPercentage: product.discountPercentage,
                    ),
                    AppSpacer(height: 10),
                    if (product.colors.isNotEmpty && showAddToCart) ...[
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: .25,
                                color: AppColors.blackDeep,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.borderRadiusFull,
                              ),
                              color: product.colors[0],
                            ),
                            width: 20,
                            height: 20,
                          ),
                          if (product.colors.length > 2)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: .25,
                                  color: AppColors.blackDeep,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.borderRadiusFull,
                                ),
                                color: product.colors[1],
                              ),
                              width: 20,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 8),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      (product.colors.length - 2).toString(),
                                      style: AppTextStyles.productName.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      AppSpacer(height: 10),
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

class AddToCart extends StatelessWidget {
  final ProductModel product;
  const AddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartProduct = state.products
            .where((p) => p.productId == product.id)
            .firstOrNull;

        return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => SelectColorDialog(product: product),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: deviceType == DeviceType.smallPhone
                ? EdgeInsets.all(0)
                : EdgeInsets.all(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(Icons.shopping_cart),
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
              AppSpacer(width: 10),
              Text(S.of(context).addToCartText),
            ],
          ),
        );
      },
    );
  }
}
