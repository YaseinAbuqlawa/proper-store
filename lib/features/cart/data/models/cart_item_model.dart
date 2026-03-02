import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store/core/helpers/json_convertors.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required String id,
    required String productId,
    required String name,
    @ColorConverter() required Color selectedColor,
    required String imageUrl,
    required double sellingPrice,
    required double discountValue,
    required int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromProductModel(
    ProductModel product, {
    int quantity = 1,
  }) {
    return CartItemModel(
      id: product.id + product.selectedColor!.toString(),
      productId: product.id,
      name: product.name,
      selectedColor: product.selectedColor!,
      imageUrl: product.imageUrls[0],
      sellingPrice: product.sellingPrice,
      discountValue: product.discountValue,
      quantity: quantity,
    );
  }

  double get offerPrice => sellingPrice - discountValue;
}
