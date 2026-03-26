import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:proper_store/features/cart/domain/repo/cart_repo.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

@LazySingleton(as: CartRepo)
class CartRepoImpl implements CartRepo {
  final CartRemoteDataSource remoteDataSource;

  CartRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, void>> saveCartItems({
    required String customerId,
    required List<CartItemModel> items,
  }) async {
    try {
      return Right(
        await remoteDataSource.saveCartItems(
          customerId: customerId,
          items: items,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<CartItemModel>>> loadCartItems({
    required String customerId,
  }) async {
    try {
      return Right(
        await remoteDataSource.loadCartItems(customerId: customerId),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
