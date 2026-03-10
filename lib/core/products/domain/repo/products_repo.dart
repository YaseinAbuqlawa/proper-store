import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<ServerFailure, ProductModel>> getProductWithId(String id);

  Future<Either<ServerFailure, List<ProductModel>>> getAllProducts();
  Future<Either<ServerFailure, List<ProductModel>>> getProductsByCategory(
    String category,
  );

  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getAllProductsPaginated({DocumentSnapshot? startAfter});

  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCategoryPaginated(
    String category, {
    DocumentSnapshot? startAfter,
  });

  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>>
  getProductsByCollectionPaginated(
    String collection, {
    DocumentSnapshot? startAfter,
  });
}
