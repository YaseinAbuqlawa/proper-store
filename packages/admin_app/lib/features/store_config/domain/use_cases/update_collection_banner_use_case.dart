import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/models/home_collection_banner_model.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/services/image_compression_service.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';

@lazySingleton
class UpdateCollectionBannerUseCase {
  final StoreConfigRepo _repo;
  final ImageCompressionService _compressionService;

  const UpdateCollectionBannerUseCase(this._repo, this._compressionService);

  Future<Either<ServerFailure, void>> call({
    required HomeCollectionBannerModel banner,
    Uint8List? newImageBytes,
  }) async {
    final compressed = newImageBytes != null
        ? await _compressionService.compress(newImageBytes)
        : null;
    return _repo.updateBanner(banner: banner, newImageBytes: compressed);
  }
}
