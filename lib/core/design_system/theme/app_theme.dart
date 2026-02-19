import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.goldRoyal,
      scaffoldBackgroundColor: AppColors.blackCard,
      cardColor: AppColors.blackCard,
      colorScheme: ColorScheme.dark(
        primary: AppColors.goldRoyal,
        secondary: AppColors.goldMuted,
        surface: AppColors.blackCard,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        surfaceTintColor: AppColors.blackCard,
        backgroundColor: AppColors.darkGray,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cairo(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.cairo(color: AppColors.whiteColor),
        bodySmall: GoogleFonts.cairo(color: AppColors.textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: AppSpacing.buttonPadding,
          backgroundColor: AppColors.goldRoyal,
          foregroundColor: AppColors.blackDeep,
          textStyle: AppTextStyles.buttonText,
          shadowColor: AppColors.goldRoyal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(
              AppSpacing.borderRadiusMedium,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: AppSpacing.buttonPadding,
          backgroundColor: AppColors.goldRoyal,
          foregroundColor: AppColors.blackDeep,
          textStyle: AppTextStyles.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(
              AppSpacing.borderRadiusMedium,
            ),
          ),
        ),
      ),
    );
  }
}
