import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class UploadProductMainImageUseCase {
  final ProductsRepo repo;

  const UploadProductMainImageUseCase({required this.repo});

  Future<Either<ServerFailure, String>> call({
    required Uint8List bytes,
    required String productId,
  }) =>
      repo.uploadMainProductImage(
        compressedImage: bytes,
        productId: productId,
      );
}
