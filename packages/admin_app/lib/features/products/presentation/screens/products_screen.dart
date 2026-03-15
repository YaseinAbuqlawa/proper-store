import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('المنتجات — قريباً', style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
