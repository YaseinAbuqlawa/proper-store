import 'package:admin/features/auth/domain/entities/staff_role.dart';

class StaffListItem {
  final String uid;
  final String username;
  final StaffRole role;
  final DateTime createdAt;

  const StaffListItem({
    required this.uid,
    required this.username,
    required this.role,
    required this.createdAt,
  });
}
