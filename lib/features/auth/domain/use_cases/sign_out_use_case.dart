import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class SignOutUseCase {
  final AuthRepo repo;
  SignOutUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call() async {
    return await repo.signOut();
  }
}
