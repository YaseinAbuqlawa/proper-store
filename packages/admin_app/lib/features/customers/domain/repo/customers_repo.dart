import 'package:fpdart/fpdart.dart';
import 'package:proper_store_shared/models/customer_model.dart';

import '../../../../core/failures/app_failures.dart';

abstract interface class CustomersRepo {
  Future<Either<ServerFailure, List<CustomerModel>>> getCustomers();
}
