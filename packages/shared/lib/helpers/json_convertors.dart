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
