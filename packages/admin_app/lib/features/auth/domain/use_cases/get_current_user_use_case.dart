import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';
import 'package:admin/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class GetCurrentUserUseCase {
  final AuthRepo repo;

  const GetCurrentUserUseCase({required this.repo});

  Future<Either<ServerFailure, StaffModel?>> call() => repo.getCurrentUser();
}
