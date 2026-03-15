import 'package:fpdart/fpdart.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/shipping_cost_model.dart';

abstract class ShippingCostRepo {
  Future<Either<ServerFailure, ShippingCostModel>> getShippingCost();
}
