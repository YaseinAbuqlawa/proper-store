import 'package:flutter/widgets.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store/core/helpers/json_convertors.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String category,
    @ColorConverter() required List<Color> colors,
    required String description,
    required double discountPercentage,
    required double discountValue,
    required String id,
    required List<String> imageUrls,
    @TimestampConverter() required DateTime lastPurchaseDate,
    required String material,
    required String name,
    required int refundedQuantity,
    required String section,
    required double sellingPrice,
    required List<double> sizes,
    required int soldQuantity,
    required int stockQuantity,
    required List<String> videoUrls,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  double offerPrice() {
    return sellingPrice - discountValue;
  }
}
