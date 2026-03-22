import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';

class FormSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const FormSectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.goldRoyal,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 20, color: AppColors.goldMuted),
        const SizedBox(width: 8),
        Text(title, style: AppTextStyles.sectionTitle),
      ],
    );
  }
}
