import 'package:flutter/material.dart';

class AppColors {
  static const Color blackDeep = Color(0xFF000000);
  static const Color goldRoyal = Color(0xFFF9C007);

  static const Color blackCard = Color(0xFF121212);
  static const Color goldMuted = Color(0xFFC5A028);
  static const Color darkGray = Color(0xFF1E1E1E);

  static const Color whiteColor = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFA0A0A0);

  // Light theme surfaces
  static const Color lightBackground = Color(0xFFF8F7F4);
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Light theme text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSubtle = Color(0xFF757575);

  static const Color errorRed = Color(0xFFCF6679);
  static const Color lightRed = Color.fromARGB(255, 255, 50, 88);
  static const Color successGreen = Color(0xFF4CAF50);

  // Light theme shadow — subtle depth on white/light surfaces
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x12000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  // Order status badge colors
  static const Color statusPendingBg = Color(0xFFF7E1A6);
  static const Color statusPendingFg = Color(0xFF736334);
  static const Color statusConfirmedBg = Color(0xFFDBE1FF);
  static const Color statusConfirmedFg = Color(0xFF415BA4);
  static const Color statusShippedBg = Color(0xFFFFF3E0);
  static const Color statusShippedFg = Color(0xFFE65100);
  static const Color statusDeliveredBg = Color(0xFFE8F5E9);
  static const Color statusDeliveredFg = Color(0xFF2E7D32);
  static const Color statusCancelledBg = Color(0xFFFFDAD6);
  static const Color statusCancelledFg = Color(0xFF93000A);

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
