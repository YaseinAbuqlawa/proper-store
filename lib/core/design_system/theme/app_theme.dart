import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.goldRoyal,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,
      colorScheme: const ColorScheme.light(
        primary: AppColors.goldRoyal,
        secondary: AppColors.goldMuted,
        surface: AppColors.lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 5,
        shadowColor: AppColors.blackDeep,
        scrolledUnderElevation: 2,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.goldRoyal,
        unselectedItemColor: AppColors.textSubtle,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AppColors.lightSurface,
        elevation: 20,
        shadowColor: Color.fromARGB(255, 0, 0, 0),
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontFamily: 'Cairo', color: AppColors.textPrimary),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(fontFamily: 'Cairo', color: AppColors.textSubtle),
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

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.goldRoyal,
      scaffoldBackgroundColor: AppColors.blackCard,
      cardColor: AppColors.darkGray,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.goldRoyal,
        secondary: AppColors.goldMuted,
        surface: AppColors.darkGray,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        surfaceTintColor: AppColors.blackCard,
        backgroundColor: AppColors.darkGray,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkGray,
        selectedItemColor: AppColors.goldRoyal,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontFamily: 'Cairo', color: AppColors.whiteColor),
        bodyMedium: TextStyle(fontFamily: 'Cairo', color: AppColors.whiteColor),
        bodySmall: TextStyle(
          fontFamily: 'Cairo',
          color: AppColors.textSecondary,
        ),
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
