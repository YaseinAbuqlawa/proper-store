import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@injectable
class ChangePasswordUseCase {
  final StaffRepo repo;

  const ChangePasswordUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String uid,
    required String newPassword,
  }) => repo.changePassword(uid: uid, newPassword: newPassword);
}
