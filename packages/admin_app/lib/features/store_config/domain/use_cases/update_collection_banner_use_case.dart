import 'dart:typed_data';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/image_compressor.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

@lazySingleton
class UpdateCollectionBannerUseCase {
  final StoreConfigRepo _repo;

  const UpdateCollectionBannerUseCase(this._repo);

  Future<Either<ServerFailure, void>> call({
    required HomeCollectionBannerModel banner,
    Uint8List? newImageBytes,
  }) async {
    final compressed = newImageBytes != null
        ? await ImageCompressor.compress(newImageBytes)
        : null;
    return _repo.updateBanner(banner: banner, newImageBytes: compressed);
  }
}
