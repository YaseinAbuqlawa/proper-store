import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

abstract class FavoritesRepo {
  Future<Either<ServerFailure, void>> setCustomerFavorites({
    required String customerId,
    required List<String> favoritesList,
  });

  Future<Either<ServerFailure, List<ProductModel>>> getFavoriteProducts({
    required List<String> favoritesList,
  });
}
