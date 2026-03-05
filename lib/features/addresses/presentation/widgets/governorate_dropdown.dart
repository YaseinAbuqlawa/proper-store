import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/helpers/egypt_governorates.dart';
import 'package:proper_store/generated/l10n.dart';

InputDecoration _addressInputDecoration(String label) {
  const radius = BorderRadius.all(Radius.circular(AppSpacing.borderRadiusMedium));
  const border = OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none);
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: AppColors.darkGray,
    border: border,
    enabledBorder: border,
    disabledBorder: border,
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: AppColors.goldRoyal, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: AppColors.errorRed),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
    ),
  );
}

class GovernorateDropdown extends StatelessWidget {
  final String? value;
  final String label;
  final ValueChanged<String?> onChanged;

  const GovernorateDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: _addressInputDecoration(label),
      dropdownColor: AppColors.darkGray,
      items: egyptGovernorates.keys
          .map((gov) => DropdownMenuItem(value: gov, child: Text(gov)))
          .toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? s.fieldRequired : null,
    );
  }
}
