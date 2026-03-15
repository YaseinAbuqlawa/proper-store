import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class StoreConfigScreen extends StatelessWidget {
  const StoreConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'إعدادات المتجر — قريباً',
          style: AppTextStyles.sectionTitle,
        ),
      ),
    );
  }
}
