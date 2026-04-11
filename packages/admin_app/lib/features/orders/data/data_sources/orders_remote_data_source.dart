import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/cart_item_normalizer.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

@lazySingleton
class OrdersRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  const OrdersRemoteDataSource({required this.firestore, required this.functions});

  Future<(List<OrderModel>, DocumentSnapshot?)> getOrders({
    DocumentSnapshot? startAfter,
    required int pageSize,
    OrderStatus? statusFilter,
    String? customerId,
  }) async {
    Query<Map<String, dynamic>> query = firestore
        .collection(AppConsts.ordersCollection)
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

    if (statusFilter != null) {
      query = query.where('status', isEqualTo: statusFilter.name);
    }

    if (customerId != null) {
      query = query.where('customerId', isEqualTo: customerId);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    final orders = snapshot.docs.map((doc) {
      final data = doc.data();
      // Handle createdAt as either Timestamp or int
      final raw = data['createdAt'];
      if (raw is Timestamp) {
        data['createdAt'] = raw.millisecondsSinceEpoch;
      }
      data['id'] = doc.id;
      data['products'] = (data['products'] as List<dynamic>? ?? [])
          .map(
            (e) => normalizeCartItemJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return OrderModel.fromJson(data);
    }).toList();

    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    return (orders, lastDoc);
  }

  Future<void> updateOrderStatus({
    required OrderModel order,
    required OrderStatus newStatus,
  }) async {
    final callable = functions.httpsCallable('updateOrderStatus');
    await callable.call({'orderId': order.id, 'newStatus': newStatus.name});
  }

  Future<CustomerModel> getCustomer({required String customerId}) async {
    final doc = await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw FirebaseException(plugin: 'cloud_firestore', code: 'not-found');
    }
    return CustomerModel.fromJson(doc.data()!);
  }
}
