import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/domain/repo/products_repo.dart';

@lazySingleton
class GetProductsByCategoryUseCase {
  final ProductsRepo repo;
  GetProductsByCategoryUseCase({required this.repo});

  Future<Either<ServerFailure, List<ProductModel>>> call(String category) =>
      repo.getProductsByCategory(category);
}
