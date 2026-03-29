import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/cart_item_normalizer.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../domain/entities/inventory_action.dart';

@lazySingleton
class OrdersRemoteDataSource {
  final FirebaseFirestore firestore;

  const OrdersRemoteDataSource({required this.firestore});

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
    required InventoryAction action,
  }) async {
    if (action == InventoryAction.none) {
      await firestore
          .collection(AppConsts.ordersCollection)
          .doc(order.id)
          .update({'status': newStatus.name});
      return;
    }

    final Map<String, List<CartItemModel>> byProduct = {};
    for (final item in order.products) {
      byProduct.putIfAbsent(item.productId, () => []).add(item);
    }

    await firestore.runTransaction((tx) async {
      final orderRef = firestore
          .collection(AppConsts.ordersCollection)
          .doc(order.id);

      // Reads must come before writes inside a Firestore transaction
      final productRefs = byProduct.keys
          .map(
            (id) => firestore.collection(AppConsts.productsCollection).doc(id),
          )
          .toList();
      final productSnaps = await Future.wait(productRefs.map(tx.get));

      tx.update(orderRef, {'status': newStatus.name});

      for (var i = 0; i < productRefs.length; i++) {
        final snap = productSnaps[i];
        if (!snap.exists) continue;

        final data = snap.data()!;
        final items = byProduct[productRefs[i].id]!;
        final updates = buildProductUpdates(
          data: data,
          items: items,
          action: action,
          newStatus: newStatus,
        );
        tx.update(productRefs[i], updates);
      }
    });
  }

  Map<String, dynamic> buildProductUpdates({
    required Map<String, dynamic> data,
    required List<CartItemModel> items,
    required InventoryAction action,
    required OrderStatus newStatus,
  }) {
    final updates = <String, dynamic>{};
    _applyVariantStockUpdates(updates, data, items, action, newStatus);
    _applyQuantityCounterUpdates(updates, data, items, action, newStatus);
    return updates;
  }

  /// Updates per-variant stock quantities and OOS derived fields.
  void _applyVariantStockUpdates(
    Map<String, dynamic> updates,
    Map<String, dynamic> data,
    List<CartItemModel> items,
    InventoryAction action,
    OrderStatus newStatus,
  ) {
    final rawVariants =
        Map<String, dynamic>.from(data['variants'] as Map? ?? {});
    final variantStocks = rawVariants.map((key, val) {
      final map = val as Map;
      return MapEntry(key, (map['stockQuantity'] as num?)?.toInt() ?? 0);
    });

    for (final item in items) {
      final key = item.variantKey;
      final currentStock = variantStocks[key] ?? 0;
      final int newStock = switch (action) {
        InventoryAction.delivery =>
          (currentStock - item.quantity).clamp(0, 999999),
        InventoryAction.cancellation => currentStock + item.quantity,
        InventoryAction.uncancellation when newStatus == OrderStatus.delivered =>
          (currentStock - item.quantity).clamp(0, 999999),
        _ => currentStock,
      };
      variantStocks[key] = newStock;
      if (newStock != currentStock) {
        // Atomic dot-notation update — does not overwrite other variant fields.
        updates['variants.$key.stockQuantity'] = newStock;
      }
    }

    final outOfStockVariants =
        variantStocks.entries.where((e) => e.value <= 0).map((e) => e.key).toList();
    updates['outOfStockVariants'] = outOfStockVariants;
    updates['hasOutOfStockVariants'] = outOfStockVariants.isNotEmpty;
    updates['totalStock'] =
        variantStocks.values.fold<int>(0, (acc, v) => acc + v);
  }

  /// Updates soldQuantity and refundedQuantity counters based on the action.
  void _applyQuantityCounterUpdates(
    Map<String, dynamic> updates,
    Map<String, dynamic> data,
    List<CartItemModel> items,
    InventoryAction action,
    OrderStatus newStatus,
  ) {
    final totalQty = items.fold<int>(0, (acc, it) => acc + it.quantity);
    final int currentSold = (data['soldQuantity'] as num?)?.toInt() ?? 0;
    final int currentRefunded =
        (data['refundedQuantity'] as num?)?.toInt() ?? 0;

    switch (action) {
      case InventoryAction.delivery:
        updates['soldQuantity'] = currentSold + totalQty;
      case InventoryAction.cancellation:
        updates['soldQuantity'] = (currentSold - totalQty).clamp(0, 999999);
        updates['refundedQuantity'] = currentRefunded + totalQty;
      case InventoryAction.uncancellation:
        updates['refundedQuantity'] =
            (currentRefunded - totalQty).clamp(0, 999999);
        if (newStatus == OrderStatus.delivered) {
          updates['soldQuantity'] = currentSold + totalQty;
        }
      case InventoryAction.none:
        break;
    }
  }

  Future<CustomerModel> getCustomer({required String customerId}) async {
    final doc = await firestore
        .collection(AppConsts.customersCollection)
        .doc(customerId)
        .get();

    return CustomerModel.fromJson(doc.data()!);
  }
}
