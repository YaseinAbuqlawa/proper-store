import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';
import 'package:admin/features/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource dataSource;

  const AuthRepoImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, StaffModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return Right(
        await dataSource.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (_) {
      return Left(FirebaseFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<void> signOut() => dataSource.signOut();
}
