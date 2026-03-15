import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart';
import 'package:proper_store_shared/models/customer_model.dart';

@lazySingleton
class SignInWithFacebookUseCase {
  final AuthRepo repo;
  SignInWithFacebookUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call() async {
    final result = await repo.signInWithFacebook();

    return result.fold((serverFailure) async => Left(serverFailure), (
      userCredential,
    ) async {
      if (!userCredential.additionalUserInfo!.isNewUser) return Right(null);

      CustomerModel customer = CustomerModel(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "مجهول",
        email: userCredential.user!.email ?? "",
        photoUrl: userCredential.user!.photoURL ?? "",
      );

      return await repo.addNewCustomer(customer: customer);
    });
  }
}
