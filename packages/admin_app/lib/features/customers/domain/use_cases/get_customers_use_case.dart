import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/customer_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/customers_repo.dart';

@lazySingleton
class GetCustomersUseCase {
  final CustomersRepo repo;

  const GetCustomersUseCase({required this.repo});

  Future<Either<ServerFailure, List<CustomerModel>>> call() => repo.getCustomers();
}
