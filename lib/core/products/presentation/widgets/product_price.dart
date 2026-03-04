import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/generated/l10n.dart';

class ProductPrice extends StatelessWidget {
  final double originalPrice;
  final double? offerPrice;
  final double discountPercentage;
  const ProductPrice({
    super.key,
    required this.discountPercentage,
    required this.originalPrice,
    this.offerPrice,
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
              S.of(context).discountLabel(discountPercentage),
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
