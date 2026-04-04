import 'dart:typed_data';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/image_compressor.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddCategoryUseCase {
  final StoreConfigRepo _repo;

  const AddCategoryUseCase(this._repo);

  Future<Either<ServerFailure, void>> call({
    required String name,
    required Uint8List imageBytes,
  }) async {
    final compressed = await ImageCompressor.compress(imageBytes);
    return _repo.addCategory(name: name, imageBytes: compressed);
  }
}
