import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/orders_repo.dart';

@lazySingleton
class GetOrdersUseCase {
  final OrdersRepo repo;

  const GetOrdersUseCase({required this.repo});

  Future<Either<ServerFailure, (List<OrderModel>, DocumentSnapshot?)>> call({
    DocumentSnapshot? startAfter,
    int pageSize = 20,
    OrderStatus? statusFilter,
  }) => repo.getOrders(
        startAfter: startAfter,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );
}
