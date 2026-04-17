import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin/features/products/presentation/models/product_variant_entry.dart';

part 'product_form_data_state.freezed.dart';

@freezed
abstract class ProductFormData with _$ProductFormData {
  const ProductFormData._();

  const factory ProductFormData({
    String? selectedCategory,
    String? existingMainImageUrl,
    Uint8List? newMainImageBytes,
    String? removedMainImageUrl,
    @Default([]) List<ProductVariantEntry> productVariants,

    /// URLs of images from fully-removed variants, to be deleted from Storage on save.
    @Default([]) List<String> removedVariantImageUrls,

    /// Transient error surfaced by async cubit operations that can't show a
    /// snackbar themselves. Listeners must clear it after displaying.
    String? transientErrorKey,
  }) = _ProductFormData;

  bool get hasMainImage =>
      existingMainImageUrl != null || newMainImageBytes != null;
}

/// Keys referenced from `S.of(context).<key>`. Cubit surfaces these;
/// UI maps them to localized strings.
class ProductFormErrorKeys {
  static const String imageTooLarge = 'imageTooLarge';
  static const String imageProcessingFailed = 'imageProcessingFailed';
}
