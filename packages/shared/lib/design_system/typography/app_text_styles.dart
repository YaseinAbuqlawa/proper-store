import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';

class AppTextStyles {
  static const TextStyle heroHeadline = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static const TextStyle productName = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle productDetailsName = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle priceNow = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.goldRoyal,
  );

  static const TextStyle priceOld = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSubtle,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.blackDeep,
  );

  static const TextStyle badgeText = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.blackDeep,
  );

  static const TextStyle bodyDescription = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSubtle,
    height: 1.6,
  );

  static const TextStyle navLabel = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle customerName = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.goldRoyal,
  );
}
