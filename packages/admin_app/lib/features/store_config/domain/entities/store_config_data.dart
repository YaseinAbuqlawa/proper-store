import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

class StoreConfigData {
  final Map<String, double> shippingCosts;
  final List<CategoryModel> categories;
  final HomeCollectionBannerModel? banner;

  const StoreConfigData({
    required this.shippingCosts,
    required this.categories,
    required this.banner,
  });
}
