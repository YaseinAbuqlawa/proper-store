import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_network_image.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_spacer.dart';
import 'package:proper_store/generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final List<Color> colors;
  final double? offerPrice;
  final String imageUrl;
  final double originalPrice;
  final String name;
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.colors,
    required this.originalPrice,
    required this.name,
    this.offerPrice,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);

    final originalPriceFormatted = NumberFormat.decimalPattern().format(
      originalPrice,
    );
    final offerPriceFormatted = NumberFormat.decimalPattern().format(
      offerPrice ?? 0,
    );

    final haveOffer = offerPriceFormatted != "0" && offerPrice != originalPrice;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: AppSpacing.cardPadding,
          margin: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  AppNetworkImage(
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: originalPriceFormatted,
                          style: haveOffer
                              ? AppTextStyles.priceOld
                              : AppTextStyles.priceNow,
                        ),
                        TextSpan(
                          text: S.of(context).currencySymbol,
                          style: haveOffer
                              ? AppTextStyles.priceOld
                              : AppTextStyles.bodyDescription,
                        ),
                        if (haveOffer) ...[
                          TextSpan(
                            text: "\n$offerPriceFormatted",
                            style: AppTextStyles.priceNow,
                          ),
                          TextSpan(
                            text: S.of(context).currencySymbol,
                            style: AppTextStyles.bodyDescription,
                          ),
                        ],
                      ],
                    ),
                  ),

                  AppSpacer(height: 10),
                  if (colors.isNotEmpty) ...[
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
        );
      },
    );
  }
}
