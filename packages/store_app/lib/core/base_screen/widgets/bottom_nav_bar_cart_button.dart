import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class BottomNavBarCartButton extends StatefulWidget {
  final void Function()? onTap;
  const BottomNavBarCartButton({super.key, required this.onTap});

  @override
  State<BottomNavBarCartButton> createState() => BottomNavBarCartButtonState();
}

class BottomNavBarCartButtonState extends State<BottomNavBarCartButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.goldRoyal.withValues(alpha: 0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.goldRoyal,
          elevation: 5,
          shape: const CircleBorder(),
          onPressed: widget.onTap,
          child: BlocSelector<CartCubit, CartState, int>(
            selector: (state) => state.products.length,
            builder: (context, count) => Stack(
              alignment: AlignmentGeometry.center,
              children: [
                if (count > 0)
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                        color: AppColors.lightRed,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.borderRadiusFull,
                        ),
                        border: Border.all(width: 2),
                      ),
                      child: Text(
                        '$count',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    key: ValueKey(count > 0),
                    count > 0
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: AppColors.blackDeep,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
