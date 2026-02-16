import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<ServerFailure, ProductModel>> getProductWithId(String id);
}
