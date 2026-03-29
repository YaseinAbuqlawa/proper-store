import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/cart_item_normalizer.dart';
import 'package:proper_store_shared/models/order_model.dart';

@lazySingleton
class OrdersRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;
  final FirebaseAuth auth;

  OrdersRemoteDataSource({
    required this.firestore,
    required this.functions,
    required this.auth,
  });

  Future<String> createOrder({required OrderModel order}) async {
    final callable = functions.httpsCallable('onOrderCreated');
    final result = await callable.call({
      'orderId': order.id,
      'customerId': order.customerId,
      'customerName': auth.currentUser?.displayName ?? '',
      'items': order.products
          .map(
            (p) => {
              'productId': p.productId,
              'variantKey': p.variantKey,
              'quantity': p.quantity,
              'sellingPrice': p.sellingPrice,
              'discountValue': p.discountValue,
              'imageUrl': p.imageUrl,
              'name': p.name,
            },
          )
          .toList(),
      'totalPrice': order.totalPrice,
      'discountTotal': order.discountTotal,
      'netTotal': order.netTotal,
      'shippingCost': order.shippingCost,
      'shippingAddress': order.shippingAddress.toJson(),
      'paymentMethod': order.paymentMethod,
      'createdAt': order.createdAt,
    });
    return result.data['orderId'] as String;
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
        'products': (data['products'] as List<dynamic>? ?? [])
            .map(
              (e) => normalizeCartItemJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList(),
      });
    }).toList();
  }
}
