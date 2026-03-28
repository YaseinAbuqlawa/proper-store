import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

void main() {
  group('ProductModel variants serialization', () {
    const color = Color(0xFFAB0000);
    const variant = ProductVariant(
      name: 'أحمر',
      color: color,
      stockQuantity: 5,
      imageUrls: ['https://example.com/img.jpg'],
    );

    Map<String, dynamic> buildJson(Map<String, dynamic> variantsJson) => {
          'category': 'bags',
          'variants': variantsJson,
          'description': 'desc',
          'discountPercentage': 0.0,
          'discountValue': 0.0,
          'id': 'test-id',
          'mainImageUrl': 'https://example.com/main.jpg',
          'lastPurchaseDate': Timestamp.fromDate(DateTime(2026)),
          'material': '',
          'name': 'Test Product',
          'refundedQuantity': 0,
          'section': 'bags',
          'sellingPrice': 100.0,
          'sizes': <double>[],
          'soldQuantity': 0,
          'stockQuantity': 5,
        };

    test('fromJson parses variants map correctly', () {
      final hexKey = variant.hexKey;
      final json = buildJson({
        hexKey: {
          'name': 'أحمر',
          'stockQuantity': 5,
          'imageUrls': ['https://example.com/img.jpg'],
        },
      });

      final product = ProductModel.fromJson(json);

      expect(product.variants.length, 1);
      expect(product.variants.containsKey(hexKey), isTrue);
      final v = product.variants[hexKey]!;
      expect(v.name, 'أحمر');
      expect(v.color, color);
      expect(v.stockQuantity, 5);
    });

    test('toJson serializes variants map without hex in values', () {
      final hexKey = variant.hexKey;
      final product = ProductModel(
        category: 'bags',
        variants: {hexKey: variant},
        description: 'desc',
        discountPercentage: 0,
        discountValue: 0,
        id: 'test-id',
        mainImageUrl: 'https://example.com/main.jpg',
        lastPurchaseDate: DateTime(2026),
        material: '',
        name: 'Test Product',
        refundedQuantity: 0,
        section: 'bags',
        sellingPrice: 100.0,
        sizes: const [],
        soldQuantity: 0,
        stockQuantity: 5,
      );

      final json = product.toJson();
      expect(json.containsKey('variants'), isTrue);
      final variantsJson = json['variants'] as Map<String, dynamic>;
      expect(variantsJson.containsKey(hexKey), isTrue);
      final variantValue = variantsJson[hexKey] as Map<String, dynamic>;
      expect(variantValue.containsKey('hex'), isFalse);
      expect(variantValue['name'], 'أحمر');
      expect(variantValue['stockQuantity'], 5);
    });

    test('round-trip fromJson → toJson → fromJson preserves variant data', () {
      final hexKey = variant.hexKey;
      final original = ProductModel(
        category: 'bags',
        variants: {hexKey: variant},
        description: 'desc',
        discountPercentage: 10,
        discountValue: 10,
        id: 'test-id',
        mainImageUrl: 'https://example.com/main.jpg',
        lastPurchaseDate: DateTime(2026),
        material: '',
        name: 'Test Product',
        refundedQuantity: 0,
        section: 'bags',
        sellingPrice: 100.0,
        sizes: const [],
        soldQuantity: 0,
        stockQuantity: 5,
      );

      final json = original.toJson();
      // Restore Timestamp for Firestore DateTime field
      json['lastPurchaseDate'] = Timestamp.fromDate(original.lastPurchaseDate);
      final restored = ProductModel.fromJson(json);

      expect(restored.variants.length, 1);
      expect(restored.variants[hexKey]!.name, 'أحمر');
      expect(restored.variants[hexKey]!.color, color);
      expect(restored.variants[hexKey]!.stockQuantity, 5);
    });

    test('variants defaults to empty map when not in JSON', () {
      final json = buildJson({});
      final product = ProductModel.fromJson(json);
      expect(product.variants.isEmpty, isTrue);
    });

    test('placeholder() has one variant', () {
      final product = ProductModel.placeholder();
      expect(product.variants.length, 1);
      expect(product.variants.values.first.name, 'رمادي');
    });

    test('totalStock field is stored and returned correctly', () {
      final hexKey = variant.hexKey;
      final product = ProductModel(
        category: 'bags',
        variants: {hexKey: variant},
        description: 'desc',
        discountPercentage: 0,
        discountValue: 0,
        id: 'test-id',
        mainImageUrl: 'https://example.com/main.jpg',
        lastPurchaseDate: DateTime(2026),
        material: '',
        name: 'Test Product',
        refundedQuantity: 0,
        section: 'bags',
        sellingPrice: 100.0,
        sizes: const [],
        soldQuantity: 0,
        stockQuantity: 5,
        totalStock: 5,
      );
      expect(product.totalStock, 5);
    });
  });
}
