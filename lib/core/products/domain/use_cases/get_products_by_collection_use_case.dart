import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/domain/repo/products_repo.dart';

@lazySingleton
class GetProductsByCollectionUseCase {
  final ProductsRepo repo;
  GetProductsByCollectionUseCase({required this.repo});

  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>> call(
    String collection, {
    DocumentSnapshot? startAfter,
  }) =>
      repo.getProductsByCollectionPaginated(collection, startAfter: startAfter);
}
