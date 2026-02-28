import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/profile/data/models/customer_model.dart';

abstract class ProfileRepo {
  Future<Either<ServerFailure, CustomerModel>> getCustomerData({
    required String customerId,
  });
}
