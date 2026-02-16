import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/features/product_details/data/data_srouces/product_details_remote_data_source.dart';
import 'package:proper_store/features/product_details/domain/repo/product_details_repo.dart';

@LazySingleton(as: ProductDetailsRepo)
class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDataSource remoteDataSource;
  ProductDetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<ProductModel>>> getRelatedProducts({
    required String productCategory,
    required String currentProductId,
  }) async {
    try {
      final products = await remoteDataSource.getRelatedProducts(
        productCategory: productCategory,
        currentProductId: currentProductId,
      );
      return Right(products);
    } on FirebaseFailure catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
