import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/product_model.dart';

abstract class ProductDetailsRepo {
  Future<Either<ServerFailure, List<ProductModel>>> getRelatedProducts({
    required String productCategory,
    required String currentProductId,
  });
}
