import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/favorites/domain/repo/favorites_repo.dart';

@lazySingleton
class SetCustomerFavoritesUseCase {
  final FavoritesRepo repo;
  SetCustomerFavoritesUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String customerId,
    required List<String> favoritesList,
  }) async {
    return await repo.setCustomerFavorites(
      customerId: customerId,
      favoritesList: favoritesList,
    );
  }
}
