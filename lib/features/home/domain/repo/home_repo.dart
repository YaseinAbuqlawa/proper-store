import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/features/home/data/models/home_collection_banner_model.dart';

abstract class HomeRepo {
  Future<Either<ServerFailure, HomeCollectionBannerModel>>
  getMainCollectionBannerData();
  Future<Either<ServerFailure, List<ProductModel>>> getMostSoldProducts();
}
