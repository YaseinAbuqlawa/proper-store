import 'package:flutter/widgets.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'package:admin/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:admin/features/orders/domain/entities/inventory_action.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Builds a minimal Firestore product data map for testing.
Map<String, dynamic> _productData({
  required Map<String, int> variantStocks,
  int soldQuantity = 0,
  int refundedQuantity = 0,
}) {
  return {
    'soldQuantity': soldQuantity,
    'refundedQuantity': refundedQuantity,
    'variants': {
      for (final e in variantStocks.entries)
        e.key: {
          'name': 'Variant ${e.key}',
          'hex': 0xFFAB0000,
          'stockQuantity': e.value,
          'imageUrls': <String>[],
        },
    },
  };
}

CartItemModel _item({
  required String variantKey,
  required int quantity,
  String productId = 'prod-1',
}) {
  return CartItemModel(
    id: '$productId-$variantKey',
    productId: productId,
    variantKey: variantKey,
    name: 'Test Product',
    selectedColor: const Color(0xFFAB0000),
    imageUrl: 'https://example.com/img.jpg',
    sellingPrice: 100.0,
    discountValue: 0.0,
    quantity: quantity,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // We test through the instance method (non-private after rename)
  // with a dummy FirebaseFirestore — the method under test is pure.
  late OrdersRemoteDataSource sut;

  setUp(() {
    // Pass a null firestore — buildProductUpdates does not use it.
    sut = OrdersRemoteDataSource(firestore: null as dynamic);
  });

  group('buildProductUpdates — delivery', () {
    test('decrements stock and marks variant OOS when stock reaches 0', () {
      final data = _productData(variantStocks: {'ffab0000': 2});
      final items = [_item(variantKey: 'ffab0000', quantity: 2)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.delivery,
        newStatus: OrderStatus.delivered,
      );

      expect(updates['variants.ffab0000.stockQuantity'], equals(0));
      expect(updates['outOfStockVariants'], contains('ffab0000'));
      expect(updates['hasOutOfStockVariants'], isTrue);
      expect(updates['totalStock'], equals(0));
      expect(updates['soldQuantity'], equals(2));
    });

    test('clamps stock at 0 when quantity exceeds current stock', () {
      final data = _productData(variantStocks: {'ffab0000': 1});
      final items = [_item(variantKey: 'ffab0000', quantity: 5)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.delivery,
        newStatus: OrderStatus.delivered,
      );

      expect(updates['variants.ffab0000.stockQuantity'], equals(0));
      expect(updates['totalStock'], equals(0));
    });

    test('does not emit dot-key when stock is unchanged', () {
      // If a variant key is not in items, stock is unchanged and no dot-key
      // should appear (avoids unnecessary Firestore writes).
      final data = _productData(variantStocks: {
        'ffab0000': 3,
        'ff001122': 5,
      });
      final items = [_item(variantKey: 'ffab0000', quantity: 1)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.delivery,
        newStatus: OrderStatus.delivered,
      );

      expect(updates.containsKey('variants.ff001122.stockQuantity'), isFalse);
      expect(updates['variants.ffab0000.stockQuantity'], equals(2));
      expect(updates['totalStock'], equals(7)); // 2 + 5
    });
  });

  group('buildProductUpdates — cancellation', () {
    test('restores stock and clears OOS flag', () {
      final data = _productData(
        variantStocks: {'ffab0000': 0},
        soldQuantity: 3,
      );
      final items = [_item(variantKey: 'ffab0000', quantity: 2)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.cancellation,
        newStatus: OrderStatus.cancelled,
      );

      expect(updates['variants.ffab0000.stockQuantity'], equals(2));
      expect(updates['outOfStockVariants'], isEmpty);
      expect(updates['hasOutOfStockVariants'], isFalse);
      expect(updates['totalStock'], equals(2));
      expect(updates['soldQuantity'], equals(1)); // 3 - 2
      expect(updates['refundedQuantity'], equals(2));
    });

    test('soldQuantity clamps at 0', () {
      final data = _productData(
        variantStocks: {'ffab0000': 0},
        soldQuantity: 1,
      );
      final items = [_item(variantKey: 'ffab0000', quantity: 5)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.cancellation,
        newStatus: OrderStatus.cancelled,
      );

      expect(updates['soldQuantity'], equals(0));
    });
  });

  group('buildProductUpdates — uncancellation', () {
    test('when newStatus=delivered: decrements stock and increments soldQty', () {
      final data = _productData(
        variantStocks: {'ffab0000': 4},
        refundedQuantity: 2,
      );
      final items = [_item(variantKey: 'ffab0000', quantity: 2)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.uncancellation,
        newStatus: OrderStatus.delivered,
      );

      expect(updates['variants.ffab0000.stockQuantity'], equals(2));
      expect(updates['totalStock'], equals(2));
      expect(updates['refundedQuantity'], equals(0)); // 2 - 2
      expect(updates['soldQuantity'], equals(2));
    });

    test('when newStatus!=delivered: only decrements refundedQuantity', () {
      final data = _productData(
        variantStocks: {'ffab0000': 4},
        refundedQuantity: 3,
      );
      final items = [_item(variantKey: 'ffab0000', quantity: 1)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.uncancellation,
        newStatus: OrderStatus.confirmed,
      );

      // Stock unchanged
      expect(updates.containsKey('variants.ffab0000.stockQuantity'), isFalse);
      expect(updates['totalStock'], equals(4));
      expect(updates['refundedQuantity'], equals(2)); // 3 - 1
      expect(updates.containsKey('soldQuantity'), isFalse);
    });
  });

  group('buildProductUpdates — OOS flags correctness', () {
    test('outOfStockVariants includes all zero-stock keys after operation', () {
      final data = _productData(variantStocks: {
        'ffab0000': 1,
        'ff001122': 0, // already OOS
      });
      final items = [_item(variantKey: 'ffab0000', quantity: 1)];

      final updates = sut.buildProductUpdates(
        data: data,
        items: items,
        action: InventoryAction.delivery,
        newStatus: OrderStatus.delivered,
      );

      final oosKeys = List<String>.from(
        updates['outOfStockVariants'] as List,
      );
      expect(oosKeys, containsAll(['ffab0000', 'ff001122']));
      expect(updates['hasOutOfStockVariants'], isTrue);
    });
  });
}
