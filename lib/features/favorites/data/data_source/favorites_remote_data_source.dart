import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

@lazySingleton
class FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  FavoritesRemoteDataSource({required this.firestore});

  Future<void> setCustomerFavorites({
    required String customerId,
    required List<String> favoritesList,
  }) async {
    await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .update({"favoritesList": favoritesList});
  }

  Future<List<ProductModel>> getFavoriteProducts({
    required List<String> favoritesList,
  }) async {
    if (favoritesList.isEmpty) return [];

    const int chunkSize = 30;

    List<Future<QuerySnapshot<Map<String, dynamic>>>> futures = [];

    for (var i = 0; i < favoritesList.length; i += chunkSize) {
      final int end = (i + chunkSize < favoritesList.length)
          ? i + chunkSize
          : favoritesList.length;
      final List<String> chunk = favoritesList.sublist(i, end);

      futures.add(
        firestore
            .collection(AppConsts.productsCollection)
            .where("id", whereIn: chunk)
            .get(),
      );
    }

    final List<QuerySnapshot<Map<String, dynamic>>> snapshots =
        await Future.wait(futures);

    List<ProductModel> allProducts = [];
    for (var snapshot in snapshots) {
      final chunkProducts = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
      allProducts.addAll(chunkProducts);
    }

    return allProducts;
  }
}
