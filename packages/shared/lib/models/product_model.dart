import 'package:flutter/widgets.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/json_convertors.dart';
import 'color_variant.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String category,
    @ColorVariantConverter() required List<ColorVariant> colors,
    @ColorVariantConverter() @Default(null) ColorVariant? selectedColor,
    required String description,
    required double discountPercentage,
    required double discountValue,
    required String id,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(0)
    int quantity,
    required List<String> imageUrls,
    @TimestampConverter() required DateTime lastPurchaseDate,
    required String material,
    required String name,
    required int refundedQuantity,
    @Default(null) String? collection,
    required String section,
    required double sellingPrice,
    required List<double> sizes,
    required int soldQuantity,
    required List<String> videoUrls,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.placeholder() => ProductModel(
    category: 'Category',
    colors: const [ColorVariant(name: 'رمادي', color: Color(0xFFBDBDBD))],
    description: 'Product description placeholder text here',
    discountPercentage: 0,
    discountValue: 0,
    id: 'placeholder-id',
    imageUrls: const ['https://placeholder.com/image.png'],
    lastPurchaseDate: DateTime(2026),
    material: 'Material',
    name: 'Product Name',
    refundedQuantity: 0,
    section: 'Section',
    sellingPrice: 99.99,
    sizes: const [40, 41, 42],
    soldQuantity: 0,
    videoUrls: const [],
  );

  int get totalStock => colors.fold(0, (sum, c) => sum + c.stockQuantity);

  double get offerPrice => sellingPrice - discountValue;
}

enum ChangeQuantityType { increase, decrease }
