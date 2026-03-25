import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';

import 'package:admin/core/helpers/image_compressor.dart';
import 'package:admin/features/products/presentation/models/product_variant_entry.dart';

import 'product_form_data_state.dart';

@injectable
class ProductFormDataCubit extends Cubit<ProductFormData> {
  ProductFormDataCubit() : super(const ProductFormData());

  void initForEdit(ProductModel product) {
    emit(
      ProductFormData(
        selectedCategory: product.category,
        existingMainImageUrl: product.mainImageUrl.isNotEmpty
            ? product.mainImageUrl
            : null,
        productVariants: product.colors
            .map(ProductVariantEntry.fromVariant)
            .toList(),
      ),
    );
  }

  void selectCategory(String? category) {
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> pickMainImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final raw = await picked.readAsBytes();
    final bytes = await ImageCompressor.compress(raw);
    emit(
      state.copyWith(
        removedMainImageUrl: state.existingMainImageUrl,
        existingMainImageUrl: null,
        newMainImageBytes: bytes,
      ),
    );
  }

  void addVariant() {
    emit(
      state.copyWith(
        productVariants: [...state.productVariants, ProductVariantEntry()],
      ),
    );
  }

  void removeVariant(int index) {
    final removed = state.productVariants[index];
    final updated = List<ProductVariantEntry>.from(state.productVariants)
      ..removeAt(index);
    emit(state.copyWith(
      productVariants: updated,
      removedVariantImageUrls: [
        ...state.removedVariantImageUrls,
        ...removed.existingImageUrls,
      ],
    ));
  }

  void notifyVariantChanged() {
    emit(state.copyWith(productVariants: List.from(state.productVariants)));
  }

  /// Returns the discount value string given price and percentage.
  String computeDiscountValue({
    required double price,
    required double percentage,
  }) {
    if (price <= 0) return '0';
    return (price * percentage / 100).toStringAsFixed(2);
  }

  /// Returns the discount percentage string given price and discount value.
  String computeDiscountPercentage({
    required double price,
    required double value,
  }) {
    if (price <= 0) return '0';
    return (value / price * 100).toStringAsFixed(2);
  }
}
