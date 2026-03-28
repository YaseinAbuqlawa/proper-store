import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@injectable
class DeleteStaffUseCase {
  final StaffRepo repo;

  const DeleteStaffUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String uid,
    required List<StaffListItem> currentStaff,
  }) async {
    final target = currentStaff.where((s) => s.uid == uid).firstOrNull;
    if (target?.role == StaffRole.superAdmin) {
      final superAdminCount =
          currentStaff.where((s) => s.role == StaffRole.superAdmin).length;
      if (superAdminCount <= 1) {
        return Left(const ServerFailure(code: 'last-superAdmin'));
      }
    }
    return repo.deleteStaff(uid);
  }
}
