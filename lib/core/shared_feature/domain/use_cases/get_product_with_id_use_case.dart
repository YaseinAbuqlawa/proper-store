import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/core/shared_feature/domain/repo/products_repo.dart';

@lazySingleton
class GetProductWithIdUseCase {
  final ProductsRepo repo;
  GetProductWithIdUseCase({required this.repo});

  Future<Either<ServerFailure, ProductModel>> call(String id) async {
    return repo.getProductWithId(id);
  }
}
