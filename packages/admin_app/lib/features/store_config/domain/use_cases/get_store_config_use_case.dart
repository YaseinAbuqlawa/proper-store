import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/store_config/domain/entities/store_config_data.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';

@lazySingleton
class GetStoreConfigUseCase {
  final StoreConfigRepo _repo;

  const GetStoreConfigUseCase(this._repo);

  Future<Either<ServerFailure, StoreConfigData>> call() async {
    final shippingResult = await _repo.getShippingCosts();
    if (shippingResult.isLeft()) {
      return shippingResult.map((_) => throw StateError('unreachable'));
    }

    final categoriesResult = await _repo.getCategories();
    if (categoriesResult.isLeft()) {
      return categoriesResult.map((_) => throw StateError('unreachable'));
    }

    final bannerResult = await _repo.getBanner();
    if (bannerResult.isLeft()) {
      return bannerResult.map((_) => throw StateError('unreachable'));
    }

    return Right(
      StoreConfigData(
        shippingCosts: shippingResult.getOrElse((_) => {}),
        categories: categoriesResult.getOrElse((_) => []),
        banner: bannerResult.getOrElse((_) => null),
      ),
    );
  }
}
