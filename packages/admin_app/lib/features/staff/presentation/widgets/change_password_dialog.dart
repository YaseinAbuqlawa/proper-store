import 'package:admin/core/widgets/admin_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart';

class ChangePasswordDialog extends StatefulWidget {
  final StaffListItem item;

  const ChangePasswordDialog({super.key, required this.item});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<StaffCubit>().changePassword(
      uid: widget.item.uid,
      newPassword: _passwordController.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.changePasswordBtn),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: s.passwordLabel,
            border: const OutlineInputBorder(),
          ),
          validator: (v) => (v == null || v.isEmpty) ? s.errorRequired : null,
        ),
      ),
      actions: [
        AdminButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          label: s.cancelBtn,
        ),
        AdminButton.primary(onPressed: _submit, label: s.changePasswordBtn),
      ],
    );
  }
}
