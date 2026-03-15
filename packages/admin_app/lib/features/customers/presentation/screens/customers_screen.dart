import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('العملاء — قريباً', style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
