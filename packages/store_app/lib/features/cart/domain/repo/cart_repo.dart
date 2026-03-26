import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

abstract class CartRepo {
  Future<Either<ServerFailure, void>> saveCartItems({
    required String customerId,
    required List<CartItemModel> items,
  });

  Future<Either<ServerFailure, List<CartItemModel>>> loadCartItems({
    required String customerId,
  });
}
