import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';

abstract class AuthRepo {
  Future<Either<ServerFailure, StaffModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
