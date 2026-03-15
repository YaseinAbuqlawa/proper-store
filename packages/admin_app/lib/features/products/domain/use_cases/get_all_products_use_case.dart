import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/products_repo.dart';

@lazySingleton
class GetAllProductsUseCase {
  final ProductsRepo repo;

  const GetAllProductsUseCase({required this.repo});

  Future<Either<ServerFailure, (List<ProductModel>, DocumentSnapshot?)>> call({
    DocumentSnapshot? startAfter,
    int pageSize = 20,
  }) => repo.getAllProducts(startAfter: startAfter, pageSize: pageSize);
}
