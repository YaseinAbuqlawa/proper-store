import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class AddCategoryUseCase {
  final ProductsRepo repo;

  const AddCategoryUseCase({required this.repo});

  Future<Either<ServerFailure, Unit>> call({
    required String name,
    required Uint8List imageBytes,
  }) async {
    final result = await repo.uploadCategoryImage(
      categoryName: name,
      compressedImage: imageBytes,
    );

    return result.fold(
      (failure) => Left(failure),
      (url) => repo.addCategory(name: name, imageUrl: url),
    );
  }
}
