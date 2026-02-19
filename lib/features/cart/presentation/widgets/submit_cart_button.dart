import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';

class SubmitCartButton extends StatelessWidget {
  const SubmitCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: AppColors.goldRoyal, blurRadius: 8)],
      ),
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 40),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "إتمام الشراء",
              style: AppTextStyles.productDetailsName.copyWith(
                color: AppColors.blackDeep,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: [
                BlocSelector<CartCubit, CartState, double>(
                  selector: (state) {
                    return state.products.totalPriceAfterDiscount;
                  },
                  builder: (context, totalPrice) {
                    return Text(
                      totalPrice.toCurrency(),
                      style: AppTextStyles.productName.copyWith(
                        color: AppColors.blackDeep,
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 20,
                  width: .5,
                  color: AppColors.blackCard,
                ),
                Icon(Icons.arrow_back, size: AppSizes.iconSizeMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
