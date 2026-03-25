import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/orders_repo.dart';

@lazySingleton
class UpdateOrderStatusUseCase {
  final OrdersRepo repo;

  const UpdateOrderStatusUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String orderId,
    required OrderStatus newStatus,
  }) => repo.updateOrderStatus(orderId: orderId, newStatus: newStatus);
}
