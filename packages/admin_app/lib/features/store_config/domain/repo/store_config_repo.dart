import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';

import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

import 'package:admin/core/failures/app_failures.dart';

abstract interface class StoreConfigRepo {
  Future<Either<ServerFailure, Map<String, double>>> getShippingCosts();
  Future<Either<ServerFailure, void>> updateShippingCosts(
    Map<String, double> costs,
  );
  Future<Either<ServerFailure, List<CategoryModel>>> getCategories();
  Future<Either<ServerFailure, void>> addCategory({
    required String name,
    required Uint8List imageBytes,
  });
  Future<Either<ServerFailure, void>> deleteCategory({
    required String id,
    required String imageUrl,
  });
  Future<Either<ServerFailure, HomeCollectionBannerModel?>> getBanner();
  Future<Either<ServerFailure, void>> updateBanner({
    required HomeCollectionBannerModel banner,
    Uint8List? newImageBytes,
  });
}
