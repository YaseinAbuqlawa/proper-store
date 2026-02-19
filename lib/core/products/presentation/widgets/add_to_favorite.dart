import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';

class AddToFavorite extends StatelessWidget {
  const AddToFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.favorite_border, color: AppColors.goldMuted),
      ),
    );
  }
}
