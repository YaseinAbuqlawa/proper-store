import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';
import 'package:admin/features/staff/domain/use_cases/change_password_use_case.dart';

class _FakeStaffRepo implements StaffRepo {
  Either<ServerFailure, void>? changePasswordResult;

  _FakeStaffRepo({this.changePasswordResult});

  @override
  Future<Either<ServerFailure, List<StaffListItem>>> getStaff() async =>
      const Right([]);

  @override
  Future<Either<ServerFailure, void>> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  }) async => const Right(null);

  @override
  Future<Either<ServerFailure, void>> changeRole({
    required String uid,
    required StaffRole role,
  }) async => const Right(null);

  @override
  Future<Either<ServerFailure, void>> changePassword({
    required String uid,
    required String newPassword,
  }) async =>
      changePasswordResult ?? const Right(null);

  @override
  Future<Either<ServerFailure, void>> deleteStaff(String uid) async =>
      const Right(null);
}

void main() {
  test('returns Right when password changed successfully', () async {
    final useCase = ChangePasswordUseCase(repo: _FakeStaffRepo());

    final result = await useCase(uid: 'uid-1', newPassword: 'newPass123');

    expect(result.isRight(), true);
  });

  test('returns failure when repo fails', () async {
    final useCase = ChangePasswordUseCase(
      repo: _FakeStaffRepo(
        changePasswordResult:
            Left(const ServerFailure(code: 'unexpected-error')),
      ),
    );

    final result = await useCase(uid: 'uid-1', newPassword: 'newPass123');

    expect(result.isLeft(), true);
  });
}
