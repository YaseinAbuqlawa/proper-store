import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@injectable
class ChangeRoleUseCase {
  final StaffRepo repo;

  const ChangeRoleUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String uid,
    required StaffRole role,
  }) => repo.changeRole(uid: uid, role: role);
}
