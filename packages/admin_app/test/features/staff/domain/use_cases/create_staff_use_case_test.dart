import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';
import 'package:admin/features/staff/domain/use_cases/create_staff_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';

class _FakeStaffRepo implements StaffRepo {
  Either<ServerFailure, void>? createResult;

  _FakeStaffRepo({this.createResult});

  @override
  Future<Either<ServerFailure, List<StaffListItem>>> getStaff() async =>
      const Right([]);

  @override
  Future<Either<ServerFailure, void>> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  }) async => createResult ?? const Right(null);

  @override
  Future<Either<ServerFailure, void>> changeRole({
    required String uid,
    required StaffRole role,
  }) async => const Right(null);

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
  test('returns Right on success', () async {
    final useCase = CreateStaffUseCase(repo: _FakeStaffRepo());

    final result = await useCase(
      username: 'alice',
      password: 'pass123',
      role: StaffRole.cs,
    );

    expect(result.isRight(), true);
  });

  test('returns failure when repo fails', () async {
    final useCase = CreateStaffUseCase(
      repo: _FakeStaffRepo(
        createResult: Left(
          const ServerFailure(code: AppConsts.unexpectedErrorText),
        ),
      ),
    );

    final result = await useCase(
      username: 'alice',
      password: 'pass123',
      role: StaffRole.cs,
    );

    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f.code, AppConsts.unexpectedErrorText),
      (_) => fail('expected Left'),
    );
  });
}
