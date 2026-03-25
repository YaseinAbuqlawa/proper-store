import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart';

@lazySingleton
class UpdateShippingCostsUseCase {
  final StoreConfigRepo _repo;

  const UpdateShippingCostsUseCase(this._repo);

  Future<Either<ServerFailure, void>> call(Map<String, double> costs) =>
      _repo.updateShippingCosts(costs);
}
