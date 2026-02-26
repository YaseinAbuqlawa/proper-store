import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class SignInWithPhoneNumberUseCase {
  final AuthRepo repo;
  SignInWithPhoneNumberUseCase({required this.repo});

  Future<Either<ServerFailure, void>> sendOtp({
    required String phoneNumber,
  }) async {
    return await repo.signInWithPhoneNumber(phoneNumber: phoneNumber);
  }

  Future<Either<ServerFailure, void>> verifyOtp({required String code}) async {
    return await repo.confirmPhoneNumber(code: code);
  }
}
