import 'dart:typed_data';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/store_config/data/data_sources/store_config_remote_data_source.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

@LazySingleton(as: StoreConfigRepo)
class StoreConfigRepoImpl implements StoreConfigRepo {
  final StoreConfigRemoteDataSource _dataSource;

  const StoreConfigRepoImpl(this._dataSource);

  @override
  Future<Either<ServerFailure, Map<String, double>>> getShippingCosts() async {
    try {
      return Right(await _dataSource.getShippingCosts());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateShippingCosts(
    Map<String, double> costs,
  ) async {
    try {
      await _dataSource.updateShippingCosts(costs);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<CategoryModel>>> getCategories() async {
    try {
      return Right(await _dataSource.getCategories());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> addCategory({
    required String name,
    required Uint8List imageBytes,
  }) async {
    try {
      final imageUrl = await _dataSource.uploadCategoryImage(
        categoryName: name,
        bytes: imageBytes,
      );
      await _dataSource.addCategory(name: name, imageUrl: imageUrl);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteCategory({
    required String id,
    required String imageUrl,
  }) async {
    try {
      await _dataSource.deleteCategory(id: id, imageUrl: imageUrl);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, HomeCollectionBannerModel?>> getBanner() async {
    try {
      return Right(await _dataSource.getBanner());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateBanner({
    required HomeCollectionBannerModel banner,
    Uint8List? newImageBytes,
  }) async {
    try {
      String imageUrl = banner.imageUrl;
      if (newImageBytes != null) {
        imageUrl = await _dataSource.uploadBannerImage(newImageBytes);
      }
      await _dataSource.updateBanner(banner.copyWith(imageUrl: imageUrl));
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
