import 'dart:typed_data';

import 'package:flutter/widgets.dart' show Color;
import 'package:proper_store_shared/models/product_model.dart';

class ProductSaveParams {
  final String name;
  final String description;
  final String category;
  final String? collection;
  final double sellingPrice;
  final double discountPercentage;
  final double discountValue;
  final String? existingMainImageUrl;
  final String? removedMainImageUrl;
  final Uint8List? newMainImageBytes;
  final List<ProductVariantSaveParams> productVariants;

  /// Non-null when editing an existing product.
  final ProductModel? existingProduct;

  const ProductSaveParams({
    required this.name,
    required this.description,
    required this.category,
    required this.collection,
    required this.sellingPrice,
    required this.discountPercentage,
    required this.discountValue,
    required this.existingMainImageUrl,
    required this.removedMainImageUrl,
    required this.newMainImageBytes,
    required this.productVariants,
    required this.existingProduct,
  });
}

class ProductVariantSaveParams {
  final String name;
  final Color color;
  final int stockQuantity;
  final List<String> existingImageUrls;
  final List<Uint8List> newImageBytes;
  final List<String> removedImageUrls;

  const ProductVariantSaveParams({
    required this.name,
    required this.color,
    required this.stockQuantity,
    required this.existingImageUrls,
    required this.newImageBytes,
    required this.removedImageUrls,
  });
}
