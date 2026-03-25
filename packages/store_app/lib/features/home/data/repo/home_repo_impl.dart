import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store/core/products/data/data_sources/products_remote_data_source.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';
import 'package:proper_store/features/home/domain/repo/home_repo.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeDataSource;
  final ProductsRemoteDataSource productsRemoteDataSource;

  HomeRepoImpl({
    required this.homeDataSource,
    required this.productsRemoteDataSource,
  });

  @override
  Future<Either<ServerFailure, HomeCollectionBannerModel>>
  getMainCollectionBannerData() async {
    try {
      return Right(await homeDataSource.getMainCollectionBannerData());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>>
  getMostSoldProducts() async {
    try {
      return Right(await productsRemoteDataSource.getMostSoldProducts());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<CategoryModel>>> getBagCategories() async {
    try {
      return Right(await homeDataSource.getBagCategories());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
