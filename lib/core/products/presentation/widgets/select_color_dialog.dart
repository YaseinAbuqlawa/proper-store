import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:proper_store/features/product_details/presentation/screens/product_details_screen.dart';

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
                  padding: EdgeInsets.all(0),
                ),
                child: Text(
                  "الغاء",
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              BlocSelector<
                ProductDetailsCubit,
                ProductDetailsState,
                ProductModel
              >(
                selector: (state) {
                  return state.whenOrNull(
                    success:
                        (productDetails, activeIndex, relatedProductsList) =>
                            productDetails,
                  )!;
                },
                builder: (context, productDetails) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().addProductToCart(
                        productDetails.copyWith(
                          quantity: 1,
                          selectedColor:
                              productDetails.selectedColor ??
                              productDetails.colors[0],
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
