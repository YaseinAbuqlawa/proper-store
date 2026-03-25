import 'package:flutter/material.dart';

const orderDetailsGold = Color(0xFFD4AF37);
const orderDetailsStone50 = Color(0xFFFAFAF9);
const orderDetailsStone100 = Color(0xFFF5F5F4);
const orderDetailsStone400 = Color(0xFFA8A29E);
const orderDetailsStone600 = Color(0xFF57534E);
const orderDetailsStone900 = Color(0xFF1C1917);

BoxDecoration orderDetailsCardDecoration() => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: orderDetailsStone100),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    );
