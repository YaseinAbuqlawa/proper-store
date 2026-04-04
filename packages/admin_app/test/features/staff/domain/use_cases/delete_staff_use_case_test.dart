import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';
import 'package:admin/features/staff/domain/use_cases/delete_staff_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';

class _FakeStaffRepo implements StaffRepo {
  Either<ServerFailure, void>? deleteResult;

  _FakeStaffRepo({this.deleteResult});

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
  }) async => const Right(null);

  @override
  Future<Either<ServerFailure, void>> deleteStaff(String uid) async =>
      deleteResult ?? const Right(null);
}

StaffListItem _makeItem(String uid, StaffRole role) => StaffListItem(
  uid: uid,
  username: uid,
  role: role,
  createdAt: DateTime(2024),
);

void main() {
  test('returns Right when staff deleted successfully', () async {
    final useCase = DeleteStaffUseCase(repo: _FakeStaffRepo());
    final staff = [
      _makeItem('uid-1', StaffRole.admin),
      _makeItem('uid-super', StaffRole.superAdmin),
    ];

    final result = await useCase(uid: 'uid-1', currentStaff: staff);

    expect(result.isRight(), true);
  });

  test('returns failure when repo fails', () async {
    final useCase = DeleteStaffUseCase(
      repo: _FakeStaffRepo(
        deleteResult: Left(
          const ServerFailure(code: AppConsts.unexpectedErrorText),
        ),
      ),
    );
    final staff = [_makeItem('uid-1', StaffRole.admin)];

    final result = await useCase(uid: 'uid-1', currentStaff: staff);

    expect(result.isLeft(), true);
  });

  test(
    'returns last-superAdmin failure when deleting the only superAdmin',
    () async {
      final useCase = DeleteStaffUseCase(repo: _FakeStaffRepo());
      final staff = [
        _makeItem('uid-super', StaffRole.superAdmin),
        _makeItem('uid-admin', StaffRole.admin),
      ];

      final result = await useCase(uid: 'uid-super', currentStaff: staff);

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f.code, 'last-superAdmin'),
        (_) => fail('expected Left'),
      );
    },
  );

  test('allows deleting a superAdmin when another superAdmin exists', () async {
    final useCase = DeleteStaffUseCase(repo: _FakeStaffRepo());
    final staff = [
      _makeItem('uid-super1', StaffRole.superAdmin),
      _makeItem('uid-super2', StaffRole.superAdmin),
    ];

    final result = await useCase(uid: 'uid-super1', currentStaff: staff);

    expect(result.isRight(), true);
  });
}
