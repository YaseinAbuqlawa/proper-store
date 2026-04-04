import 'package:proper_store_shared/failures/app_failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/dashboard_stats.dart';
import '../entities/out_of_stock_product.dart';

abstract interface class ReportsRepo {
  Future<Either<ServerFailure, DashboardStats>> getDashboardStats();
  Future<Either<ServerFailure, List<OutOfStockProduct>>>
  getOutOfStockProducts();
}
