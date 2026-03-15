import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/product_model.dart';

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
        .where("category", isEqualTo: productCategory)
        .limit(10)
        .get();

    return productsDocs.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .where((p) => p.id != currentProductId)
        .toList();
  }
}
