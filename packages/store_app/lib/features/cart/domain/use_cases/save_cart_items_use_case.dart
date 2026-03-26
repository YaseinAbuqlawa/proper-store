import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/cart/domain/repo/cart_repo.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

@lazySingleton
class SaveCartItemsUseCase {
  final CartRepo repo;

  SaveCartItemsUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String customerId,
    required List<CartItemModel> items,
  }) {
    return repo.saveCartItems(customerId: customerId, items: items);
  }
}
