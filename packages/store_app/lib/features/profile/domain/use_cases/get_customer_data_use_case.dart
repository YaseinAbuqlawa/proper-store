import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store/features/profile/domain/repo/profile_repo.dart';

@lazySingleton
class GetCustomerDataUseCase {
  final ProfileRepo repo;
  GetCustomerDataUseCase({required this.repo});

  Future<Either<ServerFailure, CustomerModel>> call({
    required String customerId,
  }) async {
    return await repo.getCustomerData(customerId: customerId);
  }
}
