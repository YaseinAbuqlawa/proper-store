import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/features/favorites/data/data_source/favorites_remote_data_source.dart';
import 'package:proper_store/features/favorites/domain/repo/favorites_repo.dart';

@LazySingleton(as: FavoritesRepo)
class FavoritesRepoImpl implements FavoritesRepo {
  final FavoritesRemoteDataSource remoteDataSource;
  FavoritesRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, void>> setCustomerFavorites({
    required String customerId,
    required List<String> favoritesList,
  }) async {
    try {
      return Right(
        await remoteDataSource.setCustomerFavorites(
          customerId: customerId,
          favoritesList: favoritesList,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getFavoriteProducts({
    required List<String> favoritesList,
  }) async {
    try {
      return Right(
        await remoteDataSource.getFavoriteProducts(
          favoritesList: favoritesList,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
