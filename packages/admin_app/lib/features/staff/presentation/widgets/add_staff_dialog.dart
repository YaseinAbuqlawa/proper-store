import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class AddStaffDialog extends StatefulWidget {
  const AddStaffDialog({super.key});

  @override
  State<AddStaffDialog> createState() => _AddStaffDialogState();
}

class _AddStaffDialogState extends State<AddStaffDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  StaffRole _selectedRole = StaffRole.cs;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<StaffCubit>().createStaff(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
      role: _selectedRole,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.addStaffBtn),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: s.staffUsernameLabel,
                border: const OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? s.errorRequired : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: s.passwordLabel,
                border: const OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? s.errorRequired : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<StaffRole>(
              initialValue: _selectedRole,
              decoration: InputDecoration(
                labelText: s.staffRoleLabel,
                border: const OutlineInputBorder(),
              ),
              items: StaffRole.values
                  .map(
                    (r) => DropdownMenuItem(
                      value: r,
                      child: Text(r.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (r) {
                if (r != null) setState(() => _selectedRole = r);
              },
            ),
          ],
        ),
      ),
      actions: [
        AdminButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          label: s.cancelBtn,
        ),
        AdminButton.primary(onPressed: _submit, label: s.addBtn),
      ],
    );
  }
}
