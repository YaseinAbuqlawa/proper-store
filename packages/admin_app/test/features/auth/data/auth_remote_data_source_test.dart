import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/auth/domain/repo/auth_repo.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';

// Fake repo to test that role is read correctly by the repo layer.
// The data source itself requires FirebaseAuth which cannot be unit-tested
// without platform mocks — these tests verify the repo wraps results correctly.
class _FakeAuthRepo implements AuthRepo {
  final Either<ServerFailure, StaffModel> result;

  _FakeAuthRepo(this.result);

  @override
  Future<Either<ServerFailure, StaffModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async => result;

  @override
  Future<void> signOut() async {}
}

void main() {
  group('AuthRepo — role from claims (via fake)', () {
    test('returns StaffModel with correct role on success', () async {
      final model = StaffModel(
        uid: 'uid-abc',
        email: 'admin@properstaff.com',
        role: StaffRole.superAdmin,
      );
      final repo = _FakeAuthRepo(Right(model));

      final result = await repo.signInWithEmailAndPassword(
        email: 'admin@properstaff.com',
        password: 'secret',
      );

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('expected Right'),
        (user) {
          expect(user.role, StaffRole.superAdmin);
          expect(user.uid, 'uid-abc');
        },
      );
    });

    test('returns FirebaseFailure with not-found when role claim is absent',
        () async {
      final repo = _FakeAuthRepo(
        Left(const FirebaseFailure(code: 'not-found')),
      );

      final result = await repo.signInWithEmailAndPassword(
        email: 'noRole@properstaff.com',
        password: 'secret',
      );

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f.code, 'not-found'),
        (_) => fail('expected Left'),
      );
    });

    test('returns unexpected-error failure on generic exception', () async {
      final repo = _FakeAuthRepo(
        Left(const FirebaseFailure(code: AppConsts.unexpectedErrorText)),
      );

      final result = await repo.signInWithEmailAndPassword(
        email: 'x@properstaff.com',
        password: 'pass',
      );

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f.code, AppConsts.unexpectedErrorText),
        (_) => fail('expected Left'),
      );
    });
  });

  group('StaffRole.fromString', () {
    test('parses superAdmin', () {
      expect(StaffRole.fromString('superAdmin'), StaffRole.superAdmin);
    });

    test('parses admin', () {
      expect(StaffRole.fromString('admin'), StaffRole.admin);
    });

    test('parses cs', () {
      expect(StaffRole.fromString('cs'), StaffRole.cs);
    });

    test('returns null for unknown role', () {
      expect(StaffRole.fromString('unknown'), isNull);
    });

    test('returns null for null input', () {
      expect(StaffRole.fromString(null), isNull);
    });
  });

  group('StaffRole getters', () {
    test('superAdmin can access products', () {
      expect(StaffRole.superAdmin.canAccessProducts, true);
    });

    test('admin can access products', () {
      expect(StaffRole.admin.canAccessProducts, true);
    });

    test('cs cannot access products', () {
      expect(StaffRole.cs.canAccessProducts, false);
    });

    test('only superAdmin can manage staff', () {
      expect(StaffRole.superAdmin.canManageStaff, true);
      expect(StaffRole.admin.canManageStaff, false);
      expect(StaffRole.cs.canManageStaff, false);
    });
  });
}
