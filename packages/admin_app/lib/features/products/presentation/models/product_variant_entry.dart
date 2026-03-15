import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:proper_store_shared/models/product_variant.dart';

class ProductVariantEntry {
  String name;
  Color color;
  int stockQuantity;
  List<String> existingImageUrls;
  List<Uint8List> newImageBytes;

  /// URLs removed by user — to be deleted from Firebase Storage at submit.
  List<String> removedImageUrls;

  ProductVariantEntry({
    this.name = '',
    this.color = const Color(0xFF000000),
    this.stockQuantity = 0,
    List<String>? existingImageUrls,
    List<Uint8List>? newImageBytes,
    List<String>? removedImageUrls,
  }) : existingImageUrls = existingImageUrls ?? [],
       newImageBytes = newImageBytes ?? [],
       removedImageUrls = removedImageUrls ?? [];

  factory ProductVariantEntry.fromVariant(ProductVariant variant) =>
      ProductVariantEntry(
        name: variant.name,
        color: variant.color,
        stockQuantity: variant.stockQuantity,
        existingImageUrls: List.from(variant.imageUrls),
      );

  bool get hasImages =>
      existingImageUrls.isNotEmpty || newImageBytes.isNotEmpty;
}
