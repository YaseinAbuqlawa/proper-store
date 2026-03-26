import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:proper_store/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';

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
                Text("اختر لون:"),
                ColorsRow(productColors: product.colors),
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
                  padding: EdgeInsets.all(0),
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
                  return ElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().addProductToCart(
                        CartItemModel.fromProductModel(
                          productDetails.copyWith(
                            selectedColor:
                                productDetails.selectedColor ??
                                productDetails.colors.firstOrNull,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                    child: Text("تأكيد"),
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
