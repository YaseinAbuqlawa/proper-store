import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

@lazySingleton
class ProductDetailsRemoteDataSource {
  final FirebaseFirestore firestore;
  ProductDetailsRemoteDataSource({required this.firestore});

  Future<List<ProductModel>> getRelatedProducts({
    required String productCategory,
    required String currentProductId,
  }) async {
    final productsDocs = await firestore
        .collection(AppConsts.productsCollection)
        .where("id", isNotEqualTo: currentProductId)
        .where("category", isEqualTo: productCategory)
        .get();

    return productsDocs.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }
}
