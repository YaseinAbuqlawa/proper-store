import 'package:flutter/widgets.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

void main() {
  group('CartItemModel.fromProductModel', () {
    const color = Color(0xFFAB0000);
    const variant = ProductVariant(
      name: 'أحمر',
      color: color,
      stockQuantity: 5,
      imageUrls: ['https://example.com/red.jpg'],
    );

    final product = ProductModel(
      id: 'prod-1',
      name: 'Test Bag',
      category: 'bags',
      variants: {variant.hexKey: variant},
      selectedColor: variant,
      description: 'desc',
      discountPercentage: 0,
      discountValue: 0,
      mainImageUrl: 'https://example.com/main.jpg',
      lastPurchaseDate: DateTime(2026),
      material: '',
      refundedQuantity: 0,
      section: 'bags',
      sellingPrice: 100,
      sizes: const [],
      shippedQuantity: 0,
    );

    test('variantKey matches hexKey of selectedColor', () {
      final item = CartItemModel.fromProductModel(product);

      expect(item.variantKey, equals(variant.hexKey));
      expect(item.variantKey, equals(color.toARGB32().toRadixString(16)));
    });

    test('variantKey is set when quantity > 1', () {
      final item = CartItemModel.fromProductModel(product, quantity: 3);

      expect(item.variantKey, equals(variant.hexKey));
      expect(item.quantity, equals(3));
    });

    test('variantKey round-trips through JSON serialization', () {
      final item = CartItemModel.fromProductModel(product);
      final json = item.toJson();
      final restored = CartItemModel.fromJson(json);

      expect(restored.variantKey, equals(item.variantKey));
    });
  });

  group('CartItemModel JSON', () {
    test('fromJson includes variantKey', () {
      final json = <String, dynamic>{
        'id': 'prod-1${Color(0xFFAB0000).toARGB32()}',
        'productId': 'prod-1',
        'variantKey': 'ffab0000',
        'name': 'Test Bag',
        'selectedColor': Color(0xFFAB0000).toARGB32(),
        'imageUrl': 'https://example.com/img.jpg',
        'sellingPrice': 100.0,
        'discountValue': 0.0,
        'quantity': 1,
      };

      final item = CartItemModel.fromJson(json);

      expect(item.variantKey, equals('ffab0000'));
    });
  });

  // ---------------------------------------------------------------------------
  // Normalization logic (reproduces the deserialization bug fixed in data
  // sources: Firestore order/cart documents may be missing variantKey or
  // selectedColor depending on when they were written).
  // ---------------------------------------------------------------------------

  /// Mirrors the _normalizeCartItemJson helper used in data sources.
  Map<String, dynamic> normalize(Map<String, dynamic> m) {
    if (m['variantKey'] == null) {
      final colorInt = (m['selectedColor'] as num?)?.toInt();
      m['variantKey'] =
          colorInt != null ? colorInt.toRadixString(16).padLeft(8, '0') : '';
    }
    if (m['selectedColor'] == null) {
      final vk = m['variantKey'] as String? ?? '';
      m['selectedColor'] = int.tryParse(vk, radix: 16) ?? 0;
    }
    if (m['id'] == null) {
      final productId = m['productId'] as String? ?? '';
      final colorInt = (m['selectedColor'] as num).toInt();
      m['id'] = '$productId$colorInt';
    }
    return m;
  }

  group('CartItemModel normalization (missing-field recovery)', () {
    const color = Color(0xFFAB0000);
    const variantKey = 'ffab0000';
    final colorInt = color.toARGB32();

    test('derives variantKey from selectedColor when missing (old cart items)', () {
      // Reproduces: old Firestore cart items saved before variantKey was added
      // to the model — fromJson would throw without normalization.
      final raw = <String, dynamic>{
        'id': 'prod-1$colorInt',
        'productId': 'prod-1',
        // variantKey missing
        'name': 'Bag',
        'selectedColor': colorInt,
        'imageUrl': 'https://example.com/img.jpg',
        'sellingPrice': 100.0,
        'discountValue': 0.0,
        'quantity': 1,
      };

      final item = CartItemModel.fromJson(normalize(raw));

      expect(item.variantKey, equals(variantKey));
      expect(item.selectedColor, equals(color));
    });

    test('derives selectedColor from variantKey when missing (Cloud Function orders)', () {
      // Reproduces: order product items stored by the Cloud Function do not
      // include selectedColor — fromJson would throw without normalization.
      final raw = <String, dynamic>{
        'id': 'prod-1$colorInt',
        'productId': 'prod-1',
        'variantKey': variantKey,
        'name': 'Bag',
        // selectedColor missing
        'imageUrl': 'https://example.com/img.jpg',
        'sellingPrice': 100.0,
        'discountValue': 0.0,
        'quantity': 1,
      };

      final item = CartItemModel.fromJson(normalize(raw));

      expect(item.selectedColor.toARGB32(), equals(colorInt));
      expect(item.variantKey, equals(variantKey));
    });

    test('derives id when missing', () {
      final raw = <String, dynamic>{
        // id missing
        'productId': 'prod-1',
        'variantKey': variantKey,
        'name': 'Bag',
        'selectedColor': colorInt,
        'imageUrl': 'https://example.com/img.jpg',
        'sellingPrice': 100.0,
        'discountValue': 0.0,
        'quantity': 1,
      };

      final item = CartItemModel.fromJson(normalize(raw));

      expect(item.id, equals('prod-1$colorInt'));
    });

    test('variantKey and selectedColor round-trip consistently', () {
      // color → variantKey → color must be lossless
      final derivedKey = colorInt.toRadixString(16).padLeft(8, '0');
      final derivedColor = int.parse(derivedKey, radix: 16);
      expect(derivedKey, equals(variantKey));
      expect(derivedColor, equals(colorInt));
    });
  });
}
