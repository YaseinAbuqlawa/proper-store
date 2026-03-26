import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/core/widgets/admin_button.dart';

class DeleteProductDialog extends StatelessWidget {
  final String productName;
  final VoidCallback onConfirm;

  const DeleteProductDialog({
    super.key,
    required this.productName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      title: Text(l.productDeleteTitle, style: AppTextStyles.sectionTitle),
      content: Text(l.productDeleteMessage, style: AppTextStyles.bodyDescription),
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
