import 'dart:typed_data';

import 'package:admin/features/products/presentation/models/product_variant_entry.dart';

// Sentinel used by copyWith to distinguish "not provided" from explicit null.
const _unchanged = Object();

class ProductFormData {
  final String? selectedCategory;
  final String? existingMainImageUrl;
  final Uint8List? newMainImageBytes;
  final String? removedMainImageUrl;
  final List<ProductVariantEntry> productVariants;

  /// URLs of images from fully-removed variants, to be deleted from Storage on save.
  final List<String> removedVariantImageUrls;

  const ProductFormData({
    this.selectedCategory,
    this.existingMainImageUrl,
    this.newMainImageBytes,
    this.removedMainImageUrl,
    this.productVariants = const [],
    this.removedVariantImageUrls = const [],
  });

  bool get hasMainImage =>
      existingMainImageUrl != null || newMainImageBytes != null;

  ProductFormData copyWith({
    Object? selectedCategory = _unchanged,
    Object? existingMainImageUrl = _unchanged,
    Object? newMainImageBytes = _unchanged,
    Object? removedMainImageUrl = _unchanged,
    List<ProductVariantEntry>? productVariants,
    List<String>? removedVariantImageUrls,
  }) {
    return ProductFormData(
      selectedCategory: identical(selectedCategory, _unchanged)
          ? this.selectedCategory
          : selectedCategory as String?,
      existingMainImageUrl: identical(existingMainImageUrl, _unchanged)
          ? this.existingMainImageUrl
          : existingMainImageUrl as String?,
      newMainImageBytes: identical(newMainImageBytes, _unchanged)
          ? this.newMainImageBytes
          : newMainImageBytes as Uint8List?,
      removedMainImageUrl: identical(removedMainImageUrl, _unchanged)
          ? this.removedMainImageUrl
          : removedMainImageUrl as String?,
      productVariants: productVariants ?? this.productVariants,
      removedVariantImageUrls:
          removedVariantImageUrls ?? this.removedVariantImageUrls,
    );
  }
}
