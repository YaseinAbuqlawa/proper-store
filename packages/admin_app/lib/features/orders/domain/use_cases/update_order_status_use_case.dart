import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../entities/inventory_action.dart';
import '../repo/orders_repo.dart';

@lazySingleton
class UpdateOrderStatusUseCase {
  final OrdersRepo repo;

  const UpdateOrderStatusUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required OrderModel order,
    required OrderStatus newStatus,
  }) {
    final action = _resolveAction(order.status, newStatus);
    return repo.updateOrderStatus(
      order: order,
      newStatus: newStatus,
      action: action,
    );
  }

  static InventoryAction _resolveAction(
    OrderStatus current,
    OrderStatus next,
  ) {
    if (current == next) return InventoryAction.none;

    const deliverableSources = {
      OrderStatus.pending,
      OrderStatus.confirmed,
      OrderStatus.shipped,
    };

    if (next == OrderStatus.delivered &&
        deliverableSources.contains(current)) {
      return InventoryAction.delivery;
    }
    if (current == OrderStatus.delivered && next == OrderStatus.cancelled) {
      return InventoryAction.cancellation;
    }
    if (current == OrderStatus.cancelled) {
      return InventoryAction.uncancellation;
    }
    return InventoryAction.none;
  }
}
