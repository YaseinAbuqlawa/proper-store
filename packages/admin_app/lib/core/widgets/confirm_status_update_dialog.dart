import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'admin_button.dart';

class ConfirmStatusUpdateDialog extends StatelessWidget {
  const ConfirmStatusUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      title: Text(
        l.confirmStatusUpdateTitle,
        style: AppTextStyles.sectionTitle,
      ),
      content: Text(
        l.confirmStatusUpdateMessage,
        style: AppTextStyles.bodyDescription,
      ),
      actions: [
        AdminButton.secondary(
          label: l.cancelLabel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        AdminButton.primary(
          label: l.confirmLabel,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
