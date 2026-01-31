import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Deep Black & Royal Gold
  static const Color blackDeep = Color(0xFF000000); // Main background
  static const Color goldRoyal = Color(
    0xFFF9C007,
  ); // Important buttons & titles

  // Secondary colors and shades
  static const Color blackCard = Color(0xFF121212); // Product card background
  static const Color goldMuted = Color(0xFFC5A028); // Secondary borders & icons
  static const Color darkGray = Color(0xFF1E1E1E); // Input fields

  // Text colors
  static const Color whiteColor = Color(
    0xFFF5F5F5,
  ); // Primary text (Pearl white)
  static const Color textSecondary = Color(
    0xFFA0A0A0,
  ); // Secondary text & old prices

  // Functional colors
  static const Color errorRed = Color(0xFFCF6679); // Error states in dark mode
  static const Color successGreen = Color(
    0xFF4CAF50,
  ); // Success states (Order completed)

  // Golden Gradient for buttons
  static const Gradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF5E0A3), Color(0xFFC5A028)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
