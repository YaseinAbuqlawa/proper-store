import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/cart/domain/repo/cart_repo.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

@lazySingleton
class LoadCartItemsUseCase {
  final CartRepo repo;

  LoadCartItemsUseCase({required this.repo});

  Future<Either<ServerFailure, List<CartItemModel>>> call({
    required String customerId,
  }) {
    return repo.loadCartItems(customerId: customerId);
  }
}
