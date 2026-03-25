import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/services/image_compression_service.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';

@lazySingleton
class AddCategoryUseCase {
  final StoreConfigRepo _repo;
  final ImageCompressionService _compressionService;

  const AddCategoryUseCase(this._repo, this._compressionService);

  Future<Either<ServerFailure, void>> call({
    required String name,
    required Uint8List imageBytes,
  }) async {
    final compressed = await _compressionService.compress(imageBytes);
    return _repo.addCategory(name: name, imageBytes: compressed);
  }
}
