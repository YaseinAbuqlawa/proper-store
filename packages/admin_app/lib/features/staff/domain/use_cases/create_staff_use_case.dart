import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@injectable
class CreateStaffUseCase {
  final StaffRepo repo;

  const CreateStaffUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String username,
    required String password,
    required StaffRole role,
  }) => repo.createStaff(username: username, password: password, role: role);
}
