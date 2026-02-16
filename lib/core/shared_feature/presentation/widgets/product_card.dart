import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_network_image.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_spacer.dart';
import 'package:proper_store/generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final List<Color> colors;
  final double? offerPrice;
  final String imageUrl;
  final double originalPrice;
  final double discountPercentage;
  final String name;
  final bool showAddToCart;
  final bool enableHero;
  const ProductCard({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.colors,
    required this.originalPrice,
    required this.name,
    required this.discountPercentage,
    this.enableHero = true,
    this.showAddToCart = true,
    this.offerPrice,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            appRouter.push(
              AppRoutes.productDetails.withId(productId),
              extra: imageUrl,
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
                            tag: imageUrl + productId,
                            child: AppNetworkImage(
                              imageUrl: imageUrl,
                              height: constraints.maxHeight * .5,
                            ),
                          )
                        : AppNetworkImage(
                            imageUrl: imageUrl,
                            height: constraints.maxHeight * .5,
                          ),
                    Container(
                      padding: AppSpacing.cardPadding,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: AppColors.goldMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppSpacer(height: 10),
                    Text(name, style: AppTextStyles.productName, maxLines: 1),
                    AppSpacer(height: 10),
                    ProductPrice(
                      originalPrice: originalPrice,
                      offerPrice: offerPrice,
                      discountPercentage: discountPercentage,
                    ),
                    AppSpacer(height: 10),
                    if (colors.isNotEmpty && showAddToCart) ...[
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
                              color: colors[0],
                            ),
                            width: 20,
                            height: 20,
                          ),
                          if (colors.length > 2)
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
                                color: colors[1],
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
                                      (colors.length - 2).toString(),
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
                    ],

                    if (showAddToCart)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: deviceType == DeviceType.smallPhone
                              ? EdgeInsets.all(0)
                              : EdgeInsets.all(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            AppSpacer(width: 10),
                            Text(S.of(context).addToCartText),
                          ],
                        ),
                      ),
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

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.favorite_border, color: AppColors.goldMuted),
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  final double originalPrice;
  final double? offerPrice;
  final bool showOfferHorizontal;
  final double discountPercentage;
  const ProductPrice({
    super.key,
    required this.discountPercentage,
    required this.originalPrice,
    this.offerPrice,
    this.showOfferHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final originalPriceFormatted = NumberFormat.decimalPattern().format(
      originalPrice,
    );
    final offerPriceFormatted = NumberFormat.decimalPattern().format(
      offerPrice ?? originalPrice,
    );

    final haveOffer = offerPriceFormatted != "0" && offerPrice != originalPrice;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveOffer)
              Text(
                originalPriceFormatted + S.of(context).currencySymbol,
                style: AppTextStyles.priceOld,
              ),
            Text(
              offerPriceFormatted + S.of(context).currencySymbol,
              style: AppTextStyles.priceNow,
            ),
          ],
        ),
        if (discountPercentage != 0)
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(25, 222, 47, 34),
              borderRadius: BorderRadius.circular(
                AppSpacing.borderRadiusMedium,
              ),
            ),
            child: Text(
              "خصم $discountPercentage%",
              style: AppTextStyles.badgeText.copyWith(
                color: AppColors.lightRed,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }
}
