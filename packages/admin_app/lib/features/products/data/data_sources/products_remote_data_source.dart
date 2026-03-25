import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/product_model.dart';

@lazySingleton
class ProductsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  const ProductsRemoteDataSource({
    required this.firestore,
    required this.storage,
  });

  String generateProductId() =>
      firestore.collection(AppConsts.productsCollection).doc().id;

  Future<(List<ProductModel>, DocumentSnapshot?)> getAllProducts({
    DocumentSnapshot? startAfter,
    required int pageSize,
  }) async {
    Query<Map<String, dynamic>> query = firestore
        .collection(AppConsts.productsCollection)
        .orderBy('name')
        .limit(pageSize);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    final products = snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();

    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    return (products, lastDoc);
  }

  Future<List<ProductModel>> searchProducts({required String query}) async {
    final snapshot = await firestore
        .collection(AppConsts.productsCollection)
        .orderBy('name')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(20)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addProduct({required ProductModel product}) async {
    await firestore
        .collection(AppConsts.productsCollection)
        .doc(product.id)
        .set(product.toJson());
  }

  Future<void> updateProduct({required ProductModel product}) async {
    await firestore
        .collection(AppConsts.productsCollection)
        .doc(product.id)
        .set(product.toJson());
  }

  Future<void> deleteProduct({required String id}) async {
    await firestore.collection(AppConsts.productsCollection).doc(id).delete();
  }

  Future<void> deleteProductImage({required String url}) async {
    await storage.refFromURL(url).delete();
  }

  Future<String> uploadMainProductImage({
    required String productId,
    required Uint8List compressedImage,
  }) async {
    final path = 'products/$productId/main.webp';
    return _upload(compressedImage: compressedImage, path: path);
  }

  Future<String> uploadProductVariantImage({
    required String productId,
    required String colorHex,
    required int index,
    required Uint8List compressedImage,
  }) async {
    final path =
        'products/$productId/colors/${colorHex}_${DateTime.now().millisecondsSinceEpoch}_$index.webp';
    return _upload(compressedImage: compressedImage, path: path);
  }

  Future<String> uploadCategoryImage({
    required String categoryName,
    required Uint8List compressedImage,
  }) async {
    final path = 'categories/$categoryName.webp';
    return _upload(compressedImage: compressedImage, path: path);
  }

  Future<List<String>> getCategories() async {
    final snapshot = await firestore
        .collection(AppConsts.bagCategoriesCollection)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return (data['name'] as String?) ?? doc.id;
    }).toList();
  }

  Future<void> addCategory({
    required String name,
    required String imageUrl,
  }) async {
    final doc = firestore.collection(AppConsts.bagCategoriesCollection).doc();

    await doc.set({'name': name, 'imageUrl': imageUrl, 'id': doc.id});
  }

  Future<String> _upload({
    required Uint8List compressedImage,
    required String path,
  }) async {
    final ref = storage.ref(path);
    final task = await ref.putData(
      compressedImage,
      SettableMetadata(contentType: 'image/webp'),
    );
    return task.ref.getDownloadURL();
  }
}
