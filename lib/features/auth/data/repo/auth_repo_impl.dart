import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart';
import 'package:proper_store/features/profile/data/models/customer_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, void>> signInAnonymously() async {
    try {
      return Right(await remoteDataSource.signInAnonymously());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      return Right(
        await remoteDataSource.signInWithPhoneNumber(phoneNumber: phoneNumber),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserCredential>> confirmPhoneNumber({
    required String code,
  }) async {
    try {
      return Right(await remoteDataSource.confirmPhoneNumber(code: code));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserCredential>> signInWithGoogle() async {
    try {
      return Right(await remoteDataSource.signInWithGoogle());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserCredential>> signInWithFacebook() async {
    try {
      return Right(await remoteDataSource.signInWithFacebook());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> addNewCustomer({
    required CustomerModel customer,
  }) async {
    try {
      return Right(await remoteDataSource.addNewCustomer(customer: customer));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> signOut() async {
    try {
      return Right(await remoteDataSource.signOut());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
