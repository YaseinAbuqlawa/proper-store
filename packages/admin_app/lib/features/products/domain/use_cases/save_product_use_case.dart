import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';
import 'package:admin/features/products/domain/use_cases/upload_color_image_use_case.dart';
import 'package:admin/features/products/domain/use_cases/upload_product_main_image_use_case.dart';
import 'package:admin/features/products/domain/use_cases/params/product_save_params.dart';

@lazySingleton
class SaveProductUseCase {
  final ProductsRepo repo;
  final UploadColorImageUseCase uploadColorImageUseCase;
  final UploadProductMainImageUseCase uploadProductMainImageUseCase;

  const SaveProductUseCase({
    required this.repo,
    required this.uploadColorImageUseCase,
    required this.uploadProductMainImageUseCase,
  });

  Future<Either<ServerFailure, void>> call(ProductSaveParams params) async {
    try {
      final productId =
          params.existingProduct?.id ?? await repo.generateProductId();

      // 1. Upload new images first — no deletions yet.
      final mainImageResult = await _uploadMainImage(params, productId);
      if (mainImageResult.isLeft()) return mainImageResult.map((_) {});
      final mainImageUrl = mainImageResult.getOrElse((_) => '');

      final variantsResult = await _uploadVariants(params, productId);
      if (variantsResult.isLeft()) return variantsResult.map((_) {});
      final productVariants = variantsResult.getOrElse((_) => []);

      // 2. Write to Firestore.
      final product = _buildProduct(
        params: params,
        productId: productId,
        mainImageUrl: mainImageUrl,
        productVariants: productVariants,
      );

      final saveResult = params.existingProduct != null
          ? await repo.updateProduct(product: product)
          : await repo.addProduct(product: product);

      if (saveResult.isLeft()) return saveResult;

      // 3. Delete old images only after Firestore write succeeds.
      //    Failures here are non-critical — Firestore already has the correct
      //    new URLs, so we swallow errors to avoid rolling back a successful save.
      await _deleteOldImages(params);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  Future<Either<ServerFailure, String>> _uploadMainImage(
    ProductSaveParams params,
    String productId,
  ) async {
    if (params.newMainImageBytes != null) {
      return uploadProductMainImageUseCase.call(
        bytes: params.newMainImageBytes!,
        productId: productId,
      );
    }
    return Right(params.existingMainImageUrl ?? '');
  }

  Future<Either<ServerFailure, List<ProductVariant>>> _uploadVariants(
    ProductSaveParams params,
    String productId,
  ) async {
    final productVariants = <ProductVariant>[];
    for (final variant in params.productVariants) {
      final uploadResult = await _uploadVariantImages(variant, productId);
      if (uploadResult.isLeft()) return uploadResult.map((_) => []);
      final uploadedUrls = uploadResult.getOrElse((_) => []);
      productVariants.add(
        ProductVariant(
          name: variant.name,
          color: variant.color,
          stockQuantity: variant.stockQuantity,
          imageUrls: [...variant.existingImageUrls, ...uploadedUrls],
        ),
      );
    }
    return Right(productVariants);
  }

  Future<Either<ServerFailure, List<String>>> _uploadVariantImages(
    ProductVariantSaveParams variant,
    String productId,
  ) async {
    final uploaded = <String>[];
    final hex = variant.color.toARGB32().toRadixString(16);

    for (int index = 0; index < variant.newImageBytes.length; index++) {
      final result = await uploadColorImageUseCase.call(
        productId: productId,
        colorHex: hex,
        index: index,
        bytes: variant.newImageBytes[index],
      );
      if (result.isLeft()) return result.map((_) => []);
      uploaded.add(result.getOrElse((_) => ''));
    }
    return Right(uploaded);
  }

  Future<void> _deleteOldImages(ProductSaveParams params) async {
    final urlsToDelete = [
      if (params.removedMainImageUrl != null) params.removedMainImageUrl!,
      for (final v in params.productVariants) ...v.removedImageUrls,
      ...params.removedVariantImageUrls,
    ];

    for (final url in urlsToDelete) {
      try {
        await repo.deleteProductImage(url: url);
      } catch (_) {
        // Non-critical: Firestore already updated. Storage cleanup failure
        // only causes an orphaned file, not data corruption.
      }
    }
  }

  ProductModel _buildProduct({
    required ProductSaveParams params,
    required String productId,
    required String mainImageUrl,
    required List<ProductVariant> productVariants,
  }) {
    final totalStockQuantity = productVariants.fold<int>(
      0,
      (previous, current) => previous + current.stockQuantity,
    );
    final variantsMap = {for (final v in productVariants) v.hexKey: v};
    return ProductModel(
      id: productId,
      name: params.name,
      description: params.description,
      category: params.category,
      collection: (params.collection?.isEmpty ?? true) ? '' : params.collection,
      section: AppConsts.sectionBags,
      material: '',
      sizes: const [],
      stockQuantity: totalStockQuantity,
      totalStock: totalStockQuantity,
      sellingPrice: params.sellingPrice,
      discountPercentage: params.discountPercentage,
      discountValue: params.discountValue,
      variants: variantsMap,
      mainImageUrl: mainImageUrl,
      soldQuantity: params.existingProduct?.soldQuantity ?? 0,
      refundedQuantity: params.existingProduct?.refundedQuantity ?? 0,
      lastPurchaseDate:
          params.existingProduct?.lastPurchaseDate ?? DateTime.now(),
    );
  }
}
