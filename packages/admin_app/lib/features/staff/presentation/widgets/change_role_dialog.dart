import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class ChangeRoleDialog extends StatefulWidget {
  final StaffListItem item;

  const ChangeRoleDialog({super.key, required this.item});

  @override
  State<ChangeRoleDialog> createState() => _ChangeRoleDialogState();
}

class _ChangeRoleDialogState extends State<ChangeRoleDialog> {
  late StaffRole _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.item.role;
  }

  void _submit() {
    context.read<StaffCubit>().changeRole(
      uid: widget.item.uid,
      role: _selectedRole,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.changeRoleBtn),
      content: DropdownButtonFormField<StaffRole>(
        initialValue: _selectedRole,
        decoration: InputDecoration(
          labelText: s.staffRoleLabel,
          border: const OutlineInputBorder(),
        ),
        items: StaffRole.values
            .map(
              (r) =>
                  DropdownMenuItem(value: r, child: Text(r.name.toUpperCase())),
            )
            .toList(),
        onChanged: (r) {
          if (r != null) setState(() => _selectedRole = r);
        },
      ),
      actions: [
        AdminButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          label: s.cancelBtn,
        ),
        AdminButton.primary(
          onPressed: _selectedRole == widget.item.role ? null : _submit,
          label: s.changeRoleBtn,
        ),
      ],
    );
  }
}
