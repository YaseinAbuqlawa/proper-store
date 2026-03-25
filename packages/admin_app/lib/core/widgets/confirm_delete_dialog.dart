import 'package:flutter/material.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    super.key,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      title: Text(l.deleteBtn, style: AppTextStyles.sectionTitle),
      content: Text(message, style: AppTextStyles.bodyDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.cancelBtn),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.errorRed),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(l.deleteBtn, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
