import 'package:flutter/material.dart';

import 'package:proper_store_shared/generated/l10n.dart';

class AdminTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? prefixIcon;
  final String? suffixText;
  final bool isRequired;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  const AdminTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixText,
    this.isRequired = false,
    this.maxLines = 1,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
        suffixText: suffixText,
      ),
      validator: isRequired
          ? (v) => (v == null || v.trim().isEmpty)
                ? S.of(context).errorRequired
                : null
          : null,
    );
  }
}
