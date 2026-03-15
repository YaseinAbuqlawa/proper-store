import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

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
      content: Text(l.productDeleteMessage, style: AppTextStyles.sectionTitle),
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
          child: Text(l.deleteBtn),
        ),
      ],
    );
  }
}
