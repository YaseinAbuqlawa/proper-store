import 'package:flutter/widgets.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/json_convertors.dart';
import 'product_variant.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String category,
    @ProductVariantMapConverter() required Map<String, ProductVariant> variants,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(null)
    ProductVariant? selectedColor,
    required String description,
    required double discountPercentage,
    required double discountValue,
    required String id,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(0)
    int quantity,
    required String mainImageUrl,
    @TimestampConverter() required DateTime lastPurchaseDate,
    required String material,
    required String name,
    required int refundedQuantity,
    @Default("") String? collection,
    required String section,
    required double sellingPrice,
    required List<double> sizes,
    required int soldQuantity,
    required int stockQuantity,
    @Default(0) int totalStock,
    @Default([]) List<String> outOfStockVariants,
    @Default(false) bool hasOutOfStockVariants,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.placeholder() {
    const variant = ProductVariant(name: 'رمادي', color: Color(0xFFBDBDBD));
    return ProductModel(
      category: 'Category',
      variants: {variant.hexKey: variant},
      description: 'Product description placeholder text here',
      discountPercentage: 0,
      discountValue: 0,
      id: 'placeholder-id',
      mainImageUrl: 'https://placeholder.com/image.png',
      lastPurchaseDate: DateTime(2026),
      material: 'Material',
      name: 'Product Name',
      refundedQuantity: 0,
      section: 'Section',
      sellingPrice: 99.99,
      sizes: const [40, 41, 42],
      soldQuantity: 0,
      stockQuantity: 0,
    );
  }

  double get offerPrice => sellingPrice - discountValue;
}

enum ChangeQuantityType { increase, decrease }
