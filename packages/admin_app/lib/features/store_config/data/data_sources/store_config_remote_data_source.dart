import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';
import 'package:proper_store_shared/models/shipping_cost_model.dart';

@lazySingleton
class StoreConfigRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  const StoreConfigRemoteDataSource({
    required this.firestore,
    required this.storage,
  });

  Future<Map<String, double>> getShippingCosts() async {
    final doc = await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.shippingAreasCostDoc)
        .get();

    if (!doc.exists || doc.data() == null) return {};
    return ShippingCostModel.fromMap(doc.data()!).areaCosts;
  }

  Future<void> updateShippingCosts(Map<String, double> costs) async {
    await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.shippingAreasCostDoc)
        .set(costs.map((k, v) => MapEntry(k, v)));
  }

  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await firestore
        .collection(AppConsts.bagCategoriesCollection)
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addCategory({
    required String name,
    required String imageUrl,
  }) async {
    final doc = firestore.collection(AppConsts.bagCategoriesCollection).doc();
    await doc.set({'id': doc.id, 'name': name, 'imageUrl': imageUrl});
  }

  Future<void> deleteCategory({
    required String id,
    required String imageUrl,
  }) async {
    await firestore
        .collection(AppConsts.bagCategoriesCollection)
        .doc(id)
        .delete();

    if (imageUrl.isNotEmpty) {
      try {
        await storage.refFromURL(imageUrl).delete();
      } catch (_) {}
    }
  }

  Future<HomeCollectionBannerModel?> getBanner() async {
    final doc = await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.storeConfigMainCollectionBannerDoc)
        .get();

    if (!doc.exists || doc.data() == null) return null;
    return HomeCollectionBannerModel.fromJson(doc.data()!);
  }

  Future<void> updateBanner(HomeCollectionBannerModel banner) async {
    await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.storeConfigMainCollectionBannerDoc)
        .set(banner.toJson());
  }

  Future<String> uploadBannerImage(Uint8List bytes) async {
    final path =
        'store_config/banner_${DateTime.now().millisecondsSinceEpoch}.webp';
    final ref = storage.ref(path);
    final task = await ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/webp'),
    );
    return task.ref.getDownloadURL();
  }

  Future<String> uploadCategoryImage({
    required String categoryName,
    required Uint8List bytes,
  }) async {
    final path =
        'categories/${categoryName}_${DateTime.now().millisecondsSinceEpoch}.webp';
    final ref = storage.ref(path);
    final task = await ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/webp'),
    );
    return task.ref.getDownloadURL();
  }
}
