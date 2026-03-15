import 'package:fpdart/fpdart.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/features/home/data/models/category_model.dart';
import 'package:proper_store/features/home/data/models/home_collection_banner_model.dart';

abstract class HomeRepo {
  Future<Either<ServerFailure, HomeCollectionBannerModel>>
  getMainCollectionBannerData();
  Future<Either<ServerFailure, List<ProductModel>>> getMostSoldProducts();
  Future<Either<ServerFailure, List<CategoryModel>>> getBagCategories();
}
