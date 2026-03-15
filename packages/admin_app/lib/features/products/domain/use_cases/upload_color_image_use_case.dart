import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/services/image_compression_service.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class UploadColorImageUseCase {
  final ProductsRepo repo;
  final ImageCompressionService compressionService;

  const UploadColorImageUseCase({
    required this.compressionService,
    required this.repo,
  });

  Future<Either<ServerFailure, String>> call({
    required Uint8List bytes,
    required String productId,
    required String colorHex,
    required int index,
  }) async {
    final compressed = await compressionService.compress(bytes);

    return await repo.uploadProductVariantImage(
      compressedImage: compressed,
      productId: productId,
      colorHex: colorHex,
      index: index,
    );
  }
}
