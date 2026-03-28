import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';

abstract interface class StaffRepo {
  Future<Either<ServerFailure, List<StaffListItem>>> getStaff();

  Future<Either<ServerFailure, void>> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  });

  Future<Either<ServerFailure, void>> changeRole({
    required String uid,
    required StaffRole role,
  });

  Future<Either<ServerFailure, void>> changePassword({
    required String uid,
    required String newPassword,
  });

  Future<Either<ServerFailure, void>> deleteStaff(String uid);
}
