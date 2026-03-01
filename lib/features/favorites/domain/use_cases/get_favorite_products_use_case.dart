import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/favorites/domain/repo/favorites_repo.dart';

@lazySingleton
class GetFavoriteProductsUseCase {
  final FavoritesRepo repo;
  GetFavoriteProductsUseCase({required this.repo});

  Future<Either<ServerFailure, List<ProductModel>>> call({
    required List<String> favoritesList,
  }) async {
    return await repo.getFavoriteProducts(favoritesList: favoritesList);
  }
}
