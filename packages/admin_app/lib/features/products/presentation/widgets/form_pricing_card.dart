import 'package:flutter/material.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';

import 'package:admin/core/widgets/admin_text_field.dart';

class FormPricingCard extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController discountPercentageController;
  final TextEditingController discountValueController;

  const FormPricingCard({
    super.key,
    required this.priceController,
    required this.discountPercentageController,
    required this.discountValueController,
  });

  String? _numericValidator(String? v, S l) {
    if (v == null || v.trim().isEmpty) return null;
    if (double.tryParse(v.trim()) == null) return l.productFormErrorInvalidNumber;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AdminTextField(
              controller: priceController,
              label: l.productFormFieldPrice,
              prefixIcon: Icons.payments_outlined,
              suffixText: AppConsts.currencySymbol,
              isRequired: true,
              keyboardType: TextInputType.number,
              validator: (v) => _numericValidator(v, l),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AdminTextField(
                    controller: discountPercentageController,
                    label: l.productFormFieldDiscountPct,
                    prefixIcon: Icons.percent_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) => _numericValidator(v, l),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AdminTextField(
                    controller: discountValueController,
                    label: l.productFormFieldDiscountVal,
                    prefixIcon: Icons.discount_outlined,
                    suffixText: AppConsts.currencySymbol,
                    keyboardType: TextInputType.number,
                    validator: (v) => _numericValidator(v, l),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
