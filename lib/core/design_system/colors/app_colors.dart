import 'package:flutter/material.dart';

class AppColors {
  static const Color blackDeep = Color(0xFF000000);
  static const Color goldRoyal = Color(0xFFF9C007);

  static const Color blackCard = Color(0xFF121212);
  static const Color goldMuted = Color(0xFFC5A028);
  static const Color darkGray = Color(0xFF1E1E1E);

  static const Color whiteColor = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFA0A0A0);

  static const Color errorRed = Color(0xFFCF6679);
  static const Color lightRed = Color.fromARGB(255, 255, 50, 88);
  static const Color successGreen = Color(0xFF4CAF50);

  static const Gradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF5E0A3), Color(0xFFC5A028)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient blackGradient = LinearGradient(
    begin: Alignment.center,
    end: Alignment.topCenter,
    colors: [AppColors.blackCard, Colors.transparent],
  );
}
