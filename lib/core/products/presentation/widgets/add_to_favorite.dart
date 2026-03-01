import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';

class AddToFavorite extends StatelessWidget {
  final void Function()? onPressed;
  final bool isFavorite;
  const AddToFavorite({
    super.key,
    required this.onPressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.goldRoyal : AppColors.goldMuted,
        ),
      ),
    );
  }
}
