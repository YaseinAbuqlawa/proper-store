import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';

import '../../../design_system/colors/app_colors.dart';
import '../../../design_system/spacing/app_spacing.dart';
import '../../../design_system/typography/app_text_styles.dart';

class AppBadgeCard extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color textColor;
  final double screenWidth;
  const AppBadgeCard({
    super.key,
    required this.screenWidth,
    this.textColor = AppColors.blackDeep,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);
    double? fontSize;
    if (deviceType == DeviceType.smallPhone) {
      fontSize = 8;
    } else if (deviceType == DeviceType.mediumPhone) {
      fontSize = 10;
    }

    late final Color backgroundColor;
    if (textColor == AppColors.blackDeep) {
      backgroundColor = AppColors.whiteColor;
    } else {
      backgroundColor = textColor.withValues(alpha: .5);
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: textColor),
          Text(
            text,
            style: AppTextStyles.badgeText.copyWith(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
