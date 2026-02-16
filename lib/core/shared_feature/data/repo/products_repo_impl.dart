import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/core/shared_feature/data/data_sources/products_remote_data_source.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/core/shared_feature/domain/repo/products_repo.dart';

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
}
