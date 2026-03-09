import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';

class AddAndMinusRow extends StatelessWidget {
  final int productQuantity;
  final String productId;
  const AddAndMinusRow({
    super.key,
    required this.productId,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.blackDeep
            : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _IconButton(
            onPressed: () {
              context.read<CartCubit>().changeProductQuantity(
                changeQuantityType: ChangeQuantityType.increase,
                productId: productId,
              );
            },
            backgroundColor: AppColors.goldRoyal,
            iconColor: AppColors.blackDeep,
            icon: Icons.add,
          ),
          SizedBox(
            width: 35,
            child: Text("$productQuantity", textAlign: TextAlign.center),
          ),
          _IconButton(
            onPressed: () {
              context.read<CartCubit>().changeProductQuantity(
                changeQuantityType: ChangeQuantityType.decrease,
                productId: productId,
              );
            },
            backgroundColor: Theme.of(context).cardColor,
            icon: Icons.remove,
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color? iconColor;
  const _IconButton({
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(25, 25),
        fixedSize: const Size(25, 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        backgroundColor: backgroundColor,
      ),
      icon: Icon(icon, size: AppSizes.iconSizeSmall, color: iconColor),
    );
  }
}
