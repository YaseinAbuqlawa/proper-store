import 'package:fpdart/fpdart.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/order_model.dart';

abstract class OrdersRepo {
  Future<Either<ServerFailure, String>> createOrder({
    required OrderModel order,
  });

  Future<Either<ServerFailure, List<OrderModel>>> getCustomerOrders({
    required String customerId,
  });
}
