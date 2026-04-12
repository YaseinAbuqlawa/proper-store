import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/product_model.dart';

@lazySingleton
class ProductsRemoteDataSource {
  final FirebaseFirestore firestore;
  ProductsRemoteDataSource({required this.firestore});

  Future<List<ProductModel>> getMostSoldProducts() async {
    final productsDocuments = await firestore
        .collection(AppConsts.productsCollection)
        .orderBy("shippedQuantity", descending: true)
        .limit(10)
        .get();

    return productsDocuments.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }

  Future<(List<ProductModel>, DocumentSnapshot?)> getAllProductsPaginated({
    DocumentSnapshot? startAfter,
    int pageSize = 12,
  }) async {
    var query = firestore
        .collection(AppConsts.productsCollection)
        .limit(pageSize);
    if (startAfter != null) query = query.startAfterDocument(startAfter);
    final snap = await query.get();
    final products = snap.docs
        .map((d) => ProductModel.fromJson(d.data()))
        .toList();
    final cursor = snap.docs.length == pageSize ? snap.docs.last : null;
    return (products, cursor);
  }

  Future<(List<ProductModel>, DocumentSnapshot?)>
  getProductsByCategoryPaginated(
    String category, {
    DocumentSnapshot? startAfter,
    int pageSize = 12,
  }) async {
    var query = firestore
        .collection(AppConsts.productsCollection)
        .where('category', isEqualTo: category)
        .limit(pageSize);
    if (startAfter != null) query = query.startAfterDocument(startAfter);
    final snap = await query.get();
    final products = snap.docs
        .map((d) => ProductModel.fromJson(d.data()))
        .toList();
    final cursor = snap.docs.length == pageSize ? snap.docs.last : null;
    return (products, cursor);
  }

  Future<(List<ProductModel>, DocumentSnapshot?)>
  getProductsByCollectionPaginated(
    String collection, {
    DocumentSnapshot? startAfter,
    int pageSize = 12,
  }) async {
    var query = firestore
        .collection(AppConsts.productsCollection)
        .where('collection', isEqualTo: collection)
        .limit(pageSize);
    if (startAfter != null) query = query.startAfterDocument(startAfter);
    final snap = await query.get();
    final products = snap.docs
        .map((d) => ProductModel.fromJson(d.data()))
        .toList();
    final cursor = snap.docs.length == pageSize ? snap.docs.last : null;
    return (products, cursor);
  }

  /// Non-paginated — preserved for backward compatibility with existing callers.
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
