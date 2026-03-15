import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/services/image_compression_service.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class UploadProductMainImageUseCase {
  final ProductsRepo repo;
  final ImageCompressionService compressionService;

  const UploadProductMainImageUseCase({
    required this.compressionService,
    required this.repo,
  });

  Future<Either<ServerFailure, String>> call({
    required Uint8List bytes,
    required String productId,
  }) async {
    final compressed = await compressionService.compress(bytes);

    return await repo.uploadMainProductImage(
      compressedImage: compressed,
      productId: productId,
    );
  }
}
