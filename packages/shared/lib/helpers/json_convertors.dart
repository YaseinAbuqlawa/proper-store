import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/color_variant.dart';

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

class ColorVariantConverter
    implements JsonConverter<ColorVariant, Map<String, dynamic>> {
  const ColorVariantConverter();

  @override
  ColorVariant fromJson(Map<String, dynamic> json) =>
      ColorVariant.fromJson(json);

  @override
  Map<String, dynamic> toJson(ColorVariant variant) => variant.toJson();
}
