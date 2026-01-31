import 'package:flutter/material.dart';

class AppSpacing {
  // --- Fixed Spacing Sizes ---
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0; // Standard spacing
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double doubleExtraLarge = 48.0;
  static const double tripleExtraLarge = 64.0;

  // --- Border Radius ---
  // Use slightly rounded or sharp corners for a premium feel
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0; // For product cards
  static const double borderRadiusLarge =
      16.0; // For large containers (e.g., modals)
  static const double borderRadiusFull = 99.0; // For perfectly circular buttons

  // --- Common Padding ---

  // General screen edge padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: small,
  );

  // Padding inside product cards
  static const EdgeInsets cardPadding = EdgeInsets.all(small);

  // Padding for large buttons
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    vertical: medium,
    horizontal: large,
  );

  // --- SizedBox Helpers ---
  // Quickly add vertical or horizontal spacing

  // Vertical spacing
  static const SizedBox verticalSpaceSmall = SizedBox(height: small);
  static const SizedBox verticalSpaceMedium = SizedBox(height: medium);
  static const SizedBox verticalSpaceLarge = SizedBox(height: large);
  static const SizedBox verticalSpaceExtraLarge = SizedBox(height: extraLarge);

  // Horizontal spacing
  static const SizedBox horizontalSpaceSmall = SizedBox(width: small);
  static const SizedBox horizontalSpaceMedium = SizedBox(width: medium);
  static const SizedBox horizontalSpaceLarge = SizedBox(width: large);
}
