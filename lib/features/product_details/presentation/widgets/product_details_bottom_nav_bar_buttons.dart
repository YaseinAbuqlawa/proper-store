import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';

class BuyNowButton extends StatelessWidget {
  final void Function()? onPressed;
  const BuyNowButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: const Text("شراء الان"));
  }
}

class AddToCartButton extends StatelessWidget {
  final void Function()? onPressed;

  const AddToCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.goldRoyal, width: .35),
        ),
      ),
      child: Text(
        "إضافة للسلة",
        style: AppTextStyles.buttonText.copyWith(color: AppColors.goldRoyal),
      ),
    );
  }
}
