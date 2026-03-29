import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/cart_item_normalizer.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

@lazySingleton
class CartRemoteDataSource {
  final FirebaseFirestore firestore;

  CartRemoteDataSource({required this.firestore});

  Future<void> saveCartItems({
    required String customerId,
    required List<CartItemModel> items,
  }) async {
    await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .update({'cartItems': items.map((e) => e.toJson()).toList()});
  }

  Future<List<CartItemModel>> loadCartItems({
    required String customerId,
  }) async {
    final doc = await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .get();

    final data = doc.data();
    if (data == null) return [];

    final raw = data['cartItems'] as List<dynamic>? ?? [];
    return raw
        .map(
          (e) => CartItemModel.fromJson(
            normalizeCartItemJson(Map<String, dynamic>.from(e as Map)),
          ),
        )
        .toList();
  }
}
