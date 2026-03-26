import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/products/domain/repo/products_repo.dart';

@lazySingleton
class GetProductsByIdsUseCase {
  final ProductsRepo repo;

  GetProductsByIdsUseCase({required this.repo});

  Future<Either<ServerFailure, List<ProductModel>>> call(List<String> ids) {
    return repo.getProductsByIds(ids);
  }
}
