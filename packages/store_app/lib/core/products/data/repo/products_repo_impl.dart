import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store/core/products/data/data_sources/products_remote_data_source.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/core/products/domain/repo/products_repo.dart';

@LazySingleton(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;
  ProductsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, ProductModel>> getProductWithId(
    String id,
  ) async {
    try {
      return Right(await remoteDataSource.getProductWithId(id));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getAllProducts() async {
    try {
      return Right(await remoteDataSource.getAllProducts());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) async {
    try {
      return Right(await remoteDataSource.getProductsByCategory(category));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getAllProductsPaginated({DocumentSnapshot? startAfter}) async {
    try {
      return Right(
        await remoteDataSource.getAllProductsPaginated(startAfter: startAfter),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCategoryPaginated(
    String category, {
    DocumentSnapshot? startAfter,
  }) async {
    try {
      return Right(
        await remoteDataSource.getProductsByCategoryPaginated(
          category,
          startAfter: startAfter,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCollectionPaginated(
    String collection, {
    DocumentSnapshot? startAfter,
  }) async {
    try {
      return Right(
        await remoteDataSource.getProductsByCollectionPaginated(
          collection,
          startAfter: startAfter,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
