import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/repo/staff_repo.dart';

@injectable
class GetStaffUseCase {
  final StaffRepo repo;

  const GetStaffUseCase({required this.repo});

  Future<Either<ServerFailure, List<StaffListItem>>> call() => repo.getStaff();
}
