import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:proper_store_shared/models/order_model.dart';
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
    } on FirebaseFunctionsException catch (e) {
      if (e.message == 'out_of_stock') {
        final details = e.details as Map<Object?, Object?>?;
        final productName = details?['productName']?.toString() ?? '';
        final variantName = details?['variantName']?.toString() ?? '';
        final available = (details?['available'] as num?)?.toInt() ?? 0;
        return Left(OutOfStockFailure(
          productName: productName,
          variantName: variantName,
          available: available,
        ));
      }
      return Left(ServerFailure(code: e.code));
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
