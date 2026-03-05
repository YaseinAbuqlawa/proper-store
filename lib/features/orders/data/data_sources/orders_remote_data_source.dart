import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';

@lazySingleton
class OrdersRemoteDataSource {
  final FirebaseFirestore firestore;

  OrdersRemoteDataSource({required this.firestore});

  Future<String> createOrder({required OrderModel order}) async {
    final docRef = firestore.collection(AppConsts.ordersCollection).doc();
    await docRef.set({
      'customerId': order.customerId,
      'products': order.products.map((p) => p.toJson()).toList(),
      'totalPrice': order.totalPrice,
      'discountTotal': order.discountTotal,
      'netTotal': order.netTotal,
      'shippingAddress': order.shippingAddress.toJson(),
      'status': order.status.name,
      'createdAt': Timestamp.now().millisecondsSinceEpoch,
      'paymentMethod': order.paymentMethod,
    });
    return docRef.id;
  }

  Future<List<OrderModel>> getCustomerOrders({
    required String customerId,
  }) async {
    final snapshot = await firestore
        .collection(AppConsts.ordersCollection)
        .where('customerId', isEqualTo: customerId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final rawTs = data['createdAt'];
      final int createdAtMs;
      if (rawTs is Timestamp) {
        createdAtMs = rawTs.millisecondsSinceEpoch;
      } else if (rawTs is int) {
        createdAtMs = rawTs;
      } else {
        createdAtMs = 0;
      }
      return OrderModel.fromJson({
        ...data,
        'id': doc.id,
        'createdAt': createdAtMs,
      });
    }).toList();
  }
}
