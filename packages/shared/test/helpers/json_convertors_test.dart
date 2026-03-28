import 'package:flutter/widgets.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:proper_store_shared/helpers/json_convertors.dart';
import 'package:proper_store_shared/models/product_variant.dart';

void main() {
  const converter = ProductVariantMapConverter();

  group('ProductVariantMapConverter', () {
    test('fromJson reconstructs variants with color from map key', () {
      const color = Color(0xFFAB0000);
      final hexKey = color.toARGB32().toRadixString(16); // 'ffab0000'
      final json = <String, dynamic>{
        hexKey: {
          'name': 'أحمر',
          'stockQuantity': 10,
          'imageUrls': ['https://example.com/img.png'],
        },
      };

      final result = converter.fromJson(json);

      expect(result.length, 1);
      expect(result.containsKey(hexKey), isTrue);
      final variant = result[hexKey]!;
      expect(variant.name, 'أحمر');
      expect(variant.color, color);
      expect(variant.stockQuantity, 10);
      expect(variant.imageUrls, ['https://example.com/img.png']);
    });

    test('toJson omits hex field from variant value', () {
      const variant = ProductVariant(
        name: 'أزرق',
        color: Color(0xFF0000FF),
        stockQuantity: 5,
        imageUrls: [],
      );
      final key = variant.hexKey;

      final result = converter.toJson({key: variant});

      expect(result.containsKey(key), isTrue);
      final value = result[key] as Map<String, dynamic>;
      expect(value.containsKey('hex'), isFalse);
      expect(value['name'], 'أزرق');
      expect(value['stockQuantity'], 5);
    });

    test('round-trip fromJson → toJson preserves data', () {
      const color = Color(0xFF123456);
      final hexKey = color.toARGB32().toRadixString(16);
      final original = <String, dynamic>{
        hexKey: {
          'name': 'test',
          'stockQuantity': 3,
          'imageUrls': ['url1', 'url2'],
        },
      };

      final variants = converter.fromJson(original);
      final serialized = converter.toJson(variants);

      expect(serialized[hexKey], isA<Map<String, dynamic>>());
      final value = serialized[hexKey] as Map<String, dynamic>;
      expect(value['name'], 'test');
      expect(value['stockQuantity'], 3);
      expect(value['imageUrls'], ['url1', 'url2']);
      expect(value.containsKey('hex'), isFalse);
    });

    test('fromJson handles empty map', () {
      final result = converter.fromJson({});
      expect(result.isEmpty, isTrue);
    });

    test('fromJson handles multiple variants', () {
      const c1 = Color(0xFFFF0000);
      const c2 = Color(0xFF00FF00);
      final k1 = c1.toARGB32().toRadixString(16);
      final k2 = c2.toARGB32().toRadixString(16);

      final json = <String, dynamic>{
        k1: {'name': 'أحمر', 'stockQuantity': 2, 'imageUrls': []},
        k2: {'name': 'أخضر', 'stockQuantity': 7, 'imageUrls': []},
      };

      final result = converter.fromJson(json);
      expect(result.length, 2);
      expect(result[k1]!.color, c1);
      expect(result[k2]!.color, c2);
    });
  });
}
