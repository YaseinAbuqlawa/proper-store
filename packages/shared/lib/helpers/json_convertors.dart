import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/product_variant.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.parse(json);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date);
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}

class ProductVariantConverter
    implements JsonConverter<ProductVariant, Map<String, dynamic>> {
  const ProductVariantConverter();

  @override
  ProductVariant fromJson(Map<String, dynamic> json) =>
      ProductVariant.fromJson(json);

  @override
  Map<String, dynamic> toJson(ProductVariant variant) => variant.toJson();
}

/// Converts a Firestore map of variants (keyed by hex string) to
/// [Map<String, ProductVariant>] and back.
///
/// Firestore format: {"ffab0000": {"name": "...", "stockQuantity": 5, "imageUrls": [...]}}
/// The hex key encodes the color — no "hex" field is stored inside the value.
class ProductVariantMapConverter
    implements JsonConverter<Map<String, ProductVariant>, Map<String, dynamic>> {
  const ProductVariantMapConverter();

  @override
  Map<String, ProductVariant> fromJson(Map<String, dynamic> json) {
    return json.map((key, value) {
      final variantJson = Map<String, dynamic>.from(value as Map<String, dynamic>);
      // Inject hex from the map key so ProductVariant.fromJson can build the Color.
      variantJson['hex'] = int.parse(key, radix: 16);
      return MapEntry(key, ProductVariant.fromJson(variantJson));
    });
  }

  @override
  Map<String, dynamic> toJson(Map<String, ProductVariant> variants) {
    return variants.map((key, variant) {
      // Omit 'hex' from the value — it is encoded as the map key.
      final json = variant.toJson()..remove('hex');
      return MapEntry(key, json);
    });
  }
}
