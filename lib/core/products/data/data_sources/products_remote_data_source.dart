import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

@lazySingleton
class ProductsRemoteDataSource {
  final FirebaseFirestore firestore;
  ProductsRemoteDataSource({required this.firestore});

  Future<List<ProductModel>> getMostSoldProducts() async {
    final productsDocuments = await firestore
        .collection(AppConsts.productsCollection)
        .orderBy("soldQuantity", descending: true)
        .limit(10)
        .get();

    return productsDocuments.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final productsDocuments = await firestore
        .collection(AppConsts.productsCollection)
        .where('category', isEqualTo: category)
        .get();

    return productsDocuments.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }

  Future<List<ProductModel>> getAllProducts() async {
    final productsDocuments = await firestore
        .collection(AppConsts.productsCollection)
        .get();

    return productsDocuments.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }

  Future<ProductModel> getProductWithId(String id) async {
    final productData = await firestore
        .collection(AppConsts.productsCollection)
        .doc(id)
        .get();

    if (!productData.exists || productData.data() == null) {
      throw Exception('Product not found: $id');
    }
    return ProductModel.fromJson(productData.data()!);
  }
}
