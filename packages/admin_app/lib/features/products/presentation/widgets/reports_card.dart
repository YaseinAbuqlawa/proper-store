import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/product_model.dart';

class ReportsCard extends StatelessWidget {
  final ProductModel product;

  const ReportsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fields = [
              _StatField(
                label: l.productFormFieldShippedQty,
                value: product.shippedQuantity.toString(),
                icon: Icons.shopping_cart_checkout_outlined,
              ),
              _StatField(
                label: l.productFormFieldRefundedQty,
                value: product.refundedQuantity.toString(),
                icon: Icons.assignment_return_outlined,
              ),
            ];
            if (constraints.maxWidth < 450) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [fields[0], const SizedBox(height: 12), fields[1]],
              );
            }
            return Row(
              children: [
                Expanded(child: fields[0]),
                const SizedBox(width: 16),
                Expanded(child: fields[1]),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.goldMuted),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.sectionTitle),
            Text(value, style: AppTextStyles.productName),
          ],
        ),
      ],
    );
  }
}
