import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';
import 'package:admin/features/staff/domain/use_cases/change_role_use_case.dart';

class _FakeStaffRepo implements StaffRepo {
  Either<ServerFailure, void>? changeRoleResult;

  _FakeStaffRepo({this.changeRoleResult});

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
  }) async =>
      changeRoleResult ?? const Right(null);

  @override
  Future<Either<ServerFailure, void>> changePassword({
    required String uid,
    required String newPassword,
  }) async => const Right(null);

  @override
  Future<Either<ServerFailure, void>> deleteStaff(String uid) async =>
      const Right(null);
}

void main() {
  test('returns Right when role changed successfully', () async {
    final useCase = ChangeRoleUseCase(repo: _FakeStaffRepo());

    final result = await useCase(uid: 'uid-1', role: StaffRole.admin);

    expect(result.isRight(), true);
  });

  test('returns failure when repo fails', () async {
    final useCase = ChangeRoleUseCase(
      repo: _FakeStaffRepo(
        changeRoleResult: Left(const ServerFailure(code: 'unexpected-error')),
      ),
    );

    final result = await useCase(uid: 'uid-1', role: StaffRole.admin);

    expect(result.isLeft(), true);
  });
}
