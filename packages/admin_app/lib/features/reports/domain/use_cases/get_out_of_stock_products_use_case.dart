import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import '../entities/out_of_stock_product.dart';
import '../repo/reports_repo.dart';

@injectable
class GetOutOfStockProductsUseCase {
  final ReportsRepo repo;

  const GetOutOfStockProductsUseCase({required this.repo});

  Future<Either<ServerFailure, List<OutOfStockProduct>>> call() =>
      repo.getOutOfStockProducts();
}
