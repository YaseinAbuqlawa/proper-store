import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/features/orders/domain/repo/orders_repo.dart';

@LazySingleton(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, String>> createOrder({
    required OrderModel order,
  }) async {
    try {
      return Right(await remoteDataSource.createOrder(order: order));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getCustomerOrders({
    required String customerId,
  }) async {
    try {
      return Right(
        await remoteDataSource.getCustomerOrders(customerId: customerId),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
