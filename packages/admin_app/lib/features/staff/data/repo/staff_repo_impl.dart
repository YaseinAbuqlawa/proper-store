import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/data/data_sources/staff_remote_data_source.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@LazySingleton(as: StaffRepo)
class StaffRepoImpl implements StaffRepo {
  final StaffRemoteDataSource dataSource;

  const StaffRepoImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, List<StaffListItem>>> getStaff() async {
    try {
      return Right(await dataSource.getStaff());
    } on FirebaseFunctionsException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  }) async {
    try {
      await dataSource.createStaff(
        username: username,
        password: password,
        role: role,
      );
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> changeRole({
    required String uid,
    required StaffRole role,
  }) async {
    try {
      await dataSource.changeRole(uid: uid, role: role);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> changePassword({
    required String uid,
    required String newPassword,
  }) async {
    try {
      await dataSource.changePassword(uid: uid, newPassword: newPassword);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteStaff(String uid) async {
    try {
      await dataSource.deleteStaff(uid);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
