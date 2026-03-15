import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

import 'package:proper_store/core/products/presentation/widgets/add_and_minus_row.dart';
import 'package:proper_store/core/products/presentation/widgets/product_price.dart';
import 'package:proper_store/core/widgets/app_network_image.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';

class CartProductCard extends StatelessWidget {
  final CartItemModel product;
  const CartProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      margin: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AppNetworkImage(imageUrl: product.imageUrl),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: AppTextStyles.productName),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).colorLabel,
                              style: AppTextStyles.bodyDescription,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.borderRadiusFull,
                              ),
                              child: Container(
                                width: 20,
                                height: 20,
                                color: product.selectedColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().removeFromCart(product.id);
                      },
                      icon: Icon(Icons.delete_outlined),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ProductPrice(
                        discountPercentage: 0,
                        originalPrice: product.sellingPrice,
                        offerPrice: product.offerPrice,
                      ),
                    ),
                    AddAndMinusRow(
                      productId: product.id,
                      productQuantity: product.quantity,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
