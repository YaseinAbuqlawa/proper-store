import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';

@lazySingleton
class DeleteCategoryUseCase {
  final StoreConfigRepo _repo;

  const DeleteCategoryUseCase(this._repo);

  Future<Either<ServerFailure, void>> call({
    required String id,
    required String imageUrl,
  }) =>
      _repo.deleteCategory(id: id, imageUrl: imageUrl);
}
