import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store/features/orders/domain/repo/orders_repo.dart';

@lazySingleton
class CreateOrderUseCase {
  final OrdersRepo repo;

  CreateOrderUseCase({required this.repo});

  Future<Either<ServerFailure, String>> call({required OrderModel order}) =>
      repo.createOrder(order: order);
}
