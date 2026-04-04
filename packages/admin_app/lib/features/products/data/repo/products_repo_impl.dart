import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@LazySingleton(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource dataSource;

  const ProductsRepoImpl({required this.dataSource});

  @override
  Future<String> generateProductId() async => dataSource.generateProductId();

  @override
  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getAllProducts({DocumentSnapshot? startAfter, required int pageSize}) async {
    try {
      return Right(
        await dataSource.getAllProducts(
          startAfter: startAfter,
          pageSize: pageSize,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>> searchProducts({
    required String query,
  }) async {
    try {
      return Right(await dataSource.searchProducts(query: query));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> addProduct({
    required ProductModel product,
  }) async {
    try {
      return Right(await dataSource.addProduct(product: product));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateProduct({
    required ProductModel product,
  }) async {
    try {
      await dataSource.updateProduct(product: product);
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteProduct({
    required String id,
  }) async {
    try {
      await dataSource.deleteProduct(id: id);
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, Unit>> deleteProductImage({
    required String url,
  }) async {
    try {
      await dataSource.deleteProductImage(url: url);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, String>> uploadMainProductImage({
    required String productId,
    required Uint8List compressedImage,
  }) async {
    try {
      return Right(
        await dataSource.uploadMainProductImage(
          productId: productId,
          compressedImage: compressedImage,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, String>> uploadProductVariantImage({
    required String productId,
    required String colorHex,
    required int index,
    required Uint8List compressedImage,
  }) async {
    try {
      return Right(
        await dataSource.uploadProductVariantImage(
          productId: productId,
          colorHex: colorHex,
          compressedImage: compressedImage,
          index: index,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, String>> uploadCategoryImage({
    required String categoryName,
    required Uint8List compressedImage,
  }) async {
    try {
      return Right(
        await dataSource.uploadCategoryImage(
          categoryName: categoryName,
          compressedImage: compressedImage,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getProductsByIds(
    List<String> ids,
  ) async {
    try {
      return Right(await dataSource.getProductsByIds(ids));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<String>>> getCategories() async {
    try {
      return Right(await dataSource.getCategories());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, Unit>> addCategory({
    required String name,
    required String imageUrl,
  }) async {
    try {
      await dataSource.addCategory(name: name, imageUrl: imageUrl);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (e) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
