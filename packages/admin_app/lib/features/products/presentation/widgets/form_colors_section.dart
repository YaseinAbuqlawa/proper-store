import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/features/products/presentation/models/product_variant_entry.dart';
import 'package:admin/features/products/presentation/widgets/product_variant_editor.dart';

class FormColorsSection extends StatelessWidget {
  final List<ProductVariantEntry> productVariants;
  final VoidCallback onAddColor;
  final void Function(int index) onRemoveColor;
  final VoidCallback onChanged;

  const FormColorsSection({
    super.key,
    required this.productVariants,
    required this.onAddColor,
    required this.onRemoveColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...productVariants.asMap().entries.map(
          (entry) => ProductVariantEditor(
            key: ValueKey(entry.key),
            entry: entry.value,
            onRemove: () => onRemoveColor(entry.key),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 4),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.goldRoyal),
            foregroundColor: AppColors.goldRoyal,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: onAddColor,
          icon: const Icon(Icons.add_circle_outline),
          label: Text(l.productFormAddColor),
        ),
      ],
    );
  }
}
