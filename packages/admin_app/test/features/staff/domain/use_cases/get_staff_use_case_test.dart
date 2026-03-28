import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';
import 'package:admin/features/staff/domain/use_cases/get_staff_use_case.dart';

class _FakeStaffRepo implements StaffRepo {
  final Either<ServerFailure, List<StaffListItem>> result;

  _FakeStaffRepo(this.result);

  @override
  Future<Either<ServerFailure, List<StaffListItem>>> getStaff() async =>
      result;

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
  }) async => const Right(null);

  @override
  Future<Either<ServerFailure, void>> deleteStaff(String uid) async =>
      const Right(null);
}

void main() {
  final sampleItem = StaffListItem(
    uid: 'uid-1',
    username: 'johndoe',
    role: StaffRole.admin,
    createdAt: DateTime(2024),
  );

  test('returns list on success', () async {
    final useCase = GetStaffUseCase(
      repo: _FakeStaffRepo(Right([sampleItem])),
    );

    final result = await useCase();

    expect(result.isRight(), true);
    result.fold(
      (_) => fail('expected Right'),
      (items) => expect(items.first.uid, 'uid-1'),
    );
  });

  test('returns failure on error', () async {
    final useCase = GetStaffUseCase(
      repo: _FakeStaffRepo(
        Left(const ServerFailure(code: 'unexpected-error')),
      ),
    );

    final result = await useCase();

    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f.code, 'unexpected-error'),
      (_) => fail('expected Left'),
    );
  });
}
