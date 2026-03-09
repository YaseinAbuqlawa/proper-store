import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/cart/data/models/cart_item_model.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

class CheckoutOrderSummary extends StatelessWidget {
  /// null = city not configured in Firestore (error state).
  /// 0.0  = explicitly free shipping.
  /// >0.0 = shipping cost in EGP.
  final double? shippingCost;

  /// When non-null, shows these items instead of the cart (Buy Now flow).
  final List<CartItemModel>? buyNowItems;

  const CheckoutOrderSummary({
    super.key,
    required this.shippingCost,
    this.buyNowItems,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocSelector<CartCubit, CartState, List<CartItemModel>>(
      selector: (state) => state.products,
      builder: (context, cartProducts) {
        final products =
            buyNowItems ?? cartProducts.where((p) => p.quantity > 0).toList();
        final netTotal = products.totalPriceAfterDiscount;
        final grandTotal = shippingCost != null
            ? netTotal + shippingCost!
            : null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.orderSummaryTitle, style: AppTextStyles.sectionTitle),
            AppSpacing.verticalSpaceSmall,
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(
                  AppSpacing.borderRadiusMedium,
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                children: [
                  ...products.map((p) => _ProductRow(product: p)),
                  if (products.isNotEmpty) ...[
                    if (products.totalDiscount != 0) ...[
                      const Divider(
                        height: AppSpacing.medium,
                        thickness: 0.2,
                        color: AppColors.textSecondary,
                      ),
                      _SummaryRow(
                        label: s.subtotalLabel,
                        value: products.totalPriceBeforeDiscount.toCurrency(),
                      ),
                      _SummaryRow(
                        label: s.discountAmountLabel,
                        value: '- ${products.totalDiscount.toCurrency()}',
                        valueColor: AppColors.successGreen,
                      ),
                    ],
                    const Divider(
                      height: AppSpacing.medium,
                      thickness: 0.2,
                      color: AppColors.textSecondary,
                    ),
                    _SummaryRow(
                      label: s.orderTotalLabel,
                      value: netTotal.toCurrency(),
                    ),
                    _SummaryRow(
                      label: s.shippingLabel,
                      value: shippingCost == null
                          ? s.shippingNotAvailable
                          : shippingCost == 0
                          ? s.shippingFree
                          : shippingCost!.toCurrency(),
                      valueColor: shippingCost == null
                          ? AppColors.errorRed
                          : shippingCost == 0
                          ? AppColors.successGreen
                          : null,
                    ),
                    if (grandTotal != null) ...[
                      const Divider(
                        height: AppSpacing.medium,
                        thickness: 0.2,
                        color: AppColors.textSecondary,
                      ),
                      _SummaryRow(
                        label: s.grandTotalLabel,
                        value: grandTotal.toCurrency(),
                        isTotal: true,
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProductRow extends StatelessWidget {
  final CartItemModel product;
  const _ProductRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: 44,
              height: 44,
              memCacheWidth: 88,
              memCacheHeight: 88,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => Container(
                width: 44,
                height: 44,
                color: AppColors.blackCard,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          AppSpacing.horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.bodyDescription.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'x${product.quantity}',
                  style: AppTextStyles.bodyDescription,
                ),
              ],
            ),
          ),
          Text(
            product.offerPrice.toCurrency(),
            style: AppTextStyles.productName,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = isTotal
        ? AppTextStyles.productDetailsName
        : AppTextStyles.bodyDescription;
    final valueStyle = isTotal
        ? AppTextStyles.productDetailsName.copyWith(color: AppColors.goldRoyal)
        : AppTextStyles.productName.copyWith(color: valueColor);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
