import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/services/image_compression_service.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class AddCategoryUseCase {
  final ProductsRepo repo;
  final ImageCompressionService compressionService;

  const AddCategoryUseCase({
    required this.repo,
    required this.compressionService,
  });

  Future<Either<ServerFailure, Unit>> call({
    required String name,
    required Uint8List imageBytes,
  }) async {
    final compressed = await compressionService.compress(imageBytes);
    final result = await repo.uploadCategoryImage(
      categoryName: name,
      compressedImage: compressed,
    );

    return result.fold(
      (serverFailure) => Left(ServerFailure(code: serverFailure.code)),
      (url) async => await repo.addCategory(name: name, imageUrl: url),
    );
  }
}
