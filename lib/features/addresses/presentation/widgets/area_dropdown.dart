import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/helpers/egypt_governorates.dart';
import 'package:proper_store/generated/l10n.dart';

InputDecoration _addressInputDecoration(String label, Color fillColor) {
  const radius = BorderRadius.all(Radius.circular(AppSpacing.borderRadiusMedium));
  const border = OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none);
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: fillColor,
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

class AreaDropdown extends StatelessWidget {
  final String? selectedCity;
  final String? initialValue;
  final String label;
  final ValueChanged<String?>? onChanged;

  const AreaDropdown({
    super.key,
    required this.selectedCity,
    required this.initialValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final areas = selectedCity != null
        ? (egyptGovernorates[selectedCity] ?? const <String>[])
        : const <String>[];
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      decoration: _addressInputDecoration(label, Theme.of(context).cardColor),
      dropdownColor: Theme.of(context).cardColor,
      items: areas
          .map((area) => DropdownMenuItem(value: area, child: Text(area)))
          .toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? s.fieldRequired : null,
    );
  }
}
