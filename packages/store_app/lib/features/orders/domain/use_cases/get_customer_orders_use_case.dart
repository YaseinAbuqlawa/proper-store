import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store/features/orders/domain/repo/orders_repo.dart';

@lazySingleton
class GetCustomerOrdersUseCase {
  final OrdersRepo repo;

  GetCustomerOrdersUseCase({required this.repo});

  Future<Either<ServerFailure, List<OrderModel>>> call({
    required String customerId,
  }) =>
      repo.getCustomerOrders(customerId: customerId);
}
