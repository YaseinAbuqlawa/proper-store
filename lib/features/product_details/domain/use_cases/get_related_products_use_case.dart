import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/features/product_details/domain/repo/product_details_repo.dart';

@lazySingleton
class GetRelatedProductsUseCase {
  final ProductDetailsRepo repo;
  GetRelatedProductsUseCase({required this.repo});

  Future<Either<ServerFailure, List<ProductModel>>> call({
    required String productCategory,
    required String currentProductId,
  }) async {
    return await repo.getRelatedProducts(
      productCategory: productCategory,
      currentProductId: currentProductId,
    );
  }
}
