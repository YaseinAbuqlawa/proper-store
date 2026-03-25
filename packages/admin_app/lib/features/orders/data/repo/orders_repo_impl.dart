import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:admin/features/orders/domain/repo/orders_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

@LazySingleton(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource dataSource;

  const OrdersRepoImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, (List<OrderModel>, DocumentSnapshot?)>>
  getOrders({
    DocumentSnapshot? startAfter,
    required int pageSize,
    OrderStatus? statusFilter,
    String? customerId,
  }) async {
    try {
      return Right(
        await dataSource.getOrders(
          startAfter: startAfter,
          pageSize: pageSize,
          statusFilter: statusFilter,
          customerId: customerId,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateOrderStatus({
    required String orderId,
    required OrderStatus newStatus,
  }) async {
    try {
      await dataSource.updateOrderStatus(
        orderId: orderId,
        newStatus: newStatus,
      );
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, CustomerModel>> getCustomer({
    required String customerId,
  }) async {
    try {
      return Right(await dataSource.getCustomer(customerId: customerId));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
