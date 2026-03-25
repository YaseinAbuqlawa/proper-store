import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/customer_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/orders_repo.dart';

@lazySingleton
class GetCustomerUseCase {
  final OrdersRepo repo;

  const GetCustomerUseCase({required this.repo});

  Future<Either<ServerFailure, CustomerModel>> call({
    required String customerId,
  }) => repo.getCustomer(customerId: customerId);
}
