import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';

class ShoppingBagButton extends StatelessWidget {
  const ShoppingBagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_bag),
          ),
          Container(
            width: 15,
            height: 15,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.goldRoyal,
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
            ),
            child: Text(
              "2",
              textAlign: TextAlign.center,
              style: AppTextStyles.badgeText.copyWith(
                color: AppColors.blackCard,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
