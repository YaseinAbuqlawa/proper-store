import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/checkout/data/models/shipping_cost_model.dart';
import 'package:proper_store/features/checkout/domain/repo/shipping_cost_repo.dart';

@lazySingleton
class GetShippingCostUseCase {
  final ShippingCostRepo repo;

  GetShippingCostUseCase({required this.repo});

  Future<Either<ServerFailure, ShippingCostModel>> call() =>
      repo.getShippingCost();
}
