import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('الطلبات — قريباً', style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
