import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/profile/data/models/customer_model.dart';

abstract class AuthRepo {
  Future<Either<ServerFailure, void>> signInAnonymously();

  Future<Either<ServerFailure, void>> signInWithPhoneNumber({
    required String phoneNumber,
  });

  Future<Either<ServerFailure, UserCredential>> confirmPhoneNumber({
    required String code,
  });

  Future<Either<ServerFailure, UserCredential>> signInWithGoogle();

  Future<Either<ServerFailure, UserCredential>> signInWithFacebook();

  Future<Either<ServerFailure, void>> addNewCustomer({
    required CustomerModel customer,
  });

  Future<Either<ServerFailure, void>> signOut();
}
