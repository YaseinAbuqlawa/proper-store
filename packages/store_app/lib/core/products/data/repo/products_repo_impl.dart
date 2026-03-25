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

  Future<Either<ServerFailure, T>> _run<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (_) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, ProductModel>> getProductWithId(
    String id,
  ) => _run(() => remoteDataSource.getProductWithId(id));

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getAllProducts() =>
      _run(() => remoteDataSource.getAllProducts());

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) => _run(() => remoteDataSource.getProductsByCategory(category));

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getAllProductsPaginated({DocumentSnapshot? startAfter}) =>
      _run(() => remoteDataSource.getAllProductsPaginated(startAfter: startAfter));

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCategoryPaginated(
    String category, {
    DocumentSnapshot? startAfter,
  }) => _run(
    () => remoteDataSource.getProductsByCategoryPaginated(
      category,
      startAfter: startAfter,
    ),
  );

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCollectionPaginated(
    String collection, {
    DocumentSnapshot? startAfter,
  }) => _run(
    () => remoteDataSource.getProductsByCollectionPaginated(
      collection,
      startAfter: startAfter,
    ),
  );
}
