import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';

class ShoppingBagButton extends StatelessWidget {
  const ShoppingBagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.cart.path),
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_bag),
          ),
          BlocSelector<CartCubit, CartState, int>(
            selector: (state) => state.products.length,
            builder: (context, count) {
              return Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.goldRoyal,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusFull,
                  ),
                ),
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.badgeText.copyWith(
                    color: AppColors.blackDeep,
                    fontSize: 10,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
