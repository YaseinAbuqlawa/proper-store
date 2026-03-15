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

      final mainImageResult = await _processMainImage(params, productId);
      if (mainImageResult.isLeft()) return mainImageResult.map((_) {});
      final mainImageUrl = mainImageResult.getOrElse((_) => '');

      final variantsResult = await _processProductVariants(params, productId);
      if (variantsResult.isLeft()) return variantsResult.map((_) {});
      final productVariants = variantsResult.getOrElse((_) => []);

      final product = _buildProduct(
        params: params,
        productId: productId,
        mainImageUrl: mainImageUrl,
        productVariants: productVariants,
      );

      return params.existingProduct != null
          ? await repo.updateProduct(product: product)
          : await repo.addProduct(product: product);
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  Future<Either<ServerFailure, String>> _processMainImage(
    ProductSaveParams params,
    String productId,
  ) async {
    if (params.removedMainImageUrl != null) {
      await repo.deleteProductImage(url: params.removedMainImageUrl!);
    }
    if (params.newMainImageBytes != null) {
      return uploadProductMainImageUseCase.call(
        bytes: params.newMainImageBytes!,
        productId: productId,
      );
    }
    return Right(params.existingMainImageUrl ?? '');
  }

  Future<Either<ServerFailure, List<ProductVariant>>> _processProductVariants(
    ProductSaveParams params,
    String productId,
  ) async {
    final productVariants = <ProductVariant>[];
    for (final variant in params.productVariants) {
      for (final url in variant.removedImageUrls) {
        await repo.deleteProductImage(url: url);
      }
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
      sellingPrice: params.sellingPrice,
      discountPercentage: params.discountPercentage,
      discountValue: params.discountValue,
      colors: productVariants,
      mainImageUrl: mainImageUrl,
      soldQuantity: params.existingProduct?.soldQuantity ?? 0,
      refundedQuantity: params.existingProduct?.refundedQuantity ?? 0,
      lastPurchaseDate:
          params.existingProduct?.lastPurchaseDate ?? DateTime.now(),
    );
  }
}
