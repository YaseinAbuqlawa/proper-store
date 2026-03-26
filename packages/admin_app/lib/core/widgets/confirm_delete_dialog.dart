import 'package:flutter/material.dart';

import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/core/widgets/admin_button.dart';

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
        AdminButton.secondary(
          label: l.cancelBtn,
          onPressed: () => Navigator.of(context).pop(),
        ),
        AdminButton.destructive(
          label: l.deleteBtn,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
