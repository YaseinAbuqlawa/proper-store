import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:proper_store/features/product_details/presentation/widgets/colors_row.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

class SelectColorDialog extends StatelessWidget {
  final ProductModel product;
  const SelectColorDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductDetailsCubit>()..setProduct(product),
      child: Builder(
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("اختر لون:"),
                ColorsRow(
                  productColors: product.variants.values.toList(),
                  outOfStockVariants: product.outOfStockVariants,
                  allowSelectOos: false,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
                  padding: EdgeInsets.zero,
                ),
                child: const Text("الغاء"),
              ),
              BlocSelector<
                ProductDetailsCubit,
                ProductDetailsState,
                ProductModel
              >(
                selector: (state) {
                  return state.maybeWhen(
                    success:
                        (productDetails, activeIndex, relatedProductsList) =>
                            productDetails ?? product,
                    orElse: () => product,
                  );
                },
                builder: (context, productDetails) {
                  final ProductVariant? effectiveVariant =
                      productDetails.selectedColor ??
                      productDetails.variants.values.firstOrNull;
                  final bool isOos = effectiveVariant != null &&
                      productDetails.outOfStockVariants
                          .contains(effectiveVariant.hexKey);

                  return ElevatedButton(
                    onPressed: isOos
                        ? null
                        : () {
                            context.read<CartCubit>().addProductToCart(
                              CartItemModel.fromProductModel(
                                productDetails.copyWith(
                                  selectedColor: effectiveVariant,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text("تأكيد"),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
