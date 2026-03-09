import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
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

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool isPhone;

  const AddressTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.isPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _addressInputDecoration(label, Theme.of(context).cardColor)
          .copyWith(hintText: hint),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return s.fieldRequired;
        if (isPhone && !RegExp(r'^01\d{9}$').hasMatch(value.trim())) {
          return s.phoneNumberMustBe10Digits;
        }
        return null;
      },
    );
  }
}
