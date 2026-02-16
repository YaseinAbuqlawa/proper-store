import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';

class AppTextStyles {
  static final TextStyle heroHeadline = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.whiteColor,
    height: 1.2,
  );

  static final TextStyle sectionTitle = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.goldRoyal,
    letterSpacing: 0.5,
  );

  static final TextStyle productName = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  static final TextStyle productDetailsName = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static final TextStyle priceNow = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.goldRoyal,
  );

  static final TextStyle priceOld = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle buttonText = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.blackDeep,
  );

  static final TextStyle badgeText = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.blackDeep,
  );

  static final TextStyle bodyDescription = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static final TextStyle navLabel = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
}
