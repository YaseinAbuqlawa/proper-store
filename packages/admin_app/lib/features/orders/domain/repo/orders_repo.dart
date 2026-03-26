import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../entities/inventory_action.dart';

abstract interface class OrdersRepo {
  Future<Either<ServerFailure, (List<OrderModel>, DocumentSnapshot?)>> getOrders({
    DocumentSnapshot? startAfter,
    required int pageSize,
    OrderStatus? statusFilter,
    String? customerId,
  });

  Future<Either<ServerFailure, void>> updateOrderStatus({
    required OrderModel order,
    required OrderStatus newStatus,
    required InventoryAction action,
  });

  Future<Either<ServerFailure, CustomerModel>> getCustomer({
    required String customerId,
  });
}
