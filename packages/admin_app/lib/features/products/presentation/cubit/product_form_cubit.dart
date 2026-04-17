import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';

import '../../domain/use_cases/params/product_save_params.dart';
import 'package:admin/core/failures/app_failures.dart';
import '../../domain/use_cases/save_product_use_case.dart';
import 'product_form_data_state.dart';

part 'product_form_cubit.freezed.dart';
part 'product_form_state.dart';

/// Error keys returned by [ProductFormCubit.validateAndSubmit] when
/// business rules fail. Widget maps these to localized messages.
class ProductFormValidationKeys {
  static const String mainImageRequired = 'productFormErrorMainImageRequired';
  static const String atLeastOneColor = 'productFormErrorAtLeastOneColor';
  static const String colorMustHaveImage = 'productFormErrorColorMustHaveImage';
}

@injectable
class ProductFormCubit extends Cubit<ProductFormState> {
  final SaveProductUseCase saveProductUseCase;

  ProductFormCubit({required this.saveProductUseCase})
    : super(const ProductFormState.initial());

  Future<void> submit(ProductSaveParams params) async {
    emit(const ProductFormState.submitting());
    final result = await saveProductUseCase.call(params);
    result.fold(
      (failure) => emit(ProductFormState.failure(failure)),
      (_) => emit(const ProductFormState.success()),
    );
  }

  /// Validates business rules against [formData] and, on success, builds
  /// [ProductSaveParams] from [input] and submits.
  ///
  /// Returns `null` if submit was kicked off, or a key from
  /// [ProductFormValidationKeys] if validation failed (widget handles snackbar).
  Future<String?> validateAndSubmit({
    required ProductFormData formData,
    required ProductFormInput input,
    ProductModel? existingProduct,
  }) async {
    if (!formData.hasMainImage) {
      return ProductFormValidationKeys.mainImageRequired;
    }
    if (formData.productVariants.isEmpty) {
      return ProductFormValidationKeys.atLeastOneColor;
    }
    final variantWithoutImage = formData.productVariants
        .where((v) => !v.hasImages)
        .firstOrNull;
    if (variantWithoutImage != null) {
      return ProductFormValidationKeys.colorMustHaveImage;
    }

    final collectionText = input.collection.trim();
    await submit(
      ProductSaveParams(
        name: input.name.trim(),
        description: input.description.trim(),
        category: formData.selectedCategory!,
        collection: collectionText.isEmpty ? null : collectionText,
        sellingPrice: double.tryParse(input.sellingPrice.trim()) ?? 0,
        discountPercentage:
            double.tryParse(input.discountPercentage.trim()) ?? 0,
        discountValue: double.tryParse(input.discountValue.trim()) ?? 0,
        existingMainImageUrl: formData.existingMainImageUrl,
        removedMainImageUrl: formData.removedMainImageUrl,
        newMainImageBytes: formData.newMainImageBytes,
        productVariants: formData.productVariants
            .map(
              (e) => ProductVariantSaveParams(
                name: e.name,
                color: e.color,
                stockQuantity: e.stockQuantity,
                existingImageUrls: e.existingImageUrls,
                newImageBytes: e.newImageBytes,
                removedImageUrls: e.removedImageUrls,
              ),
            )
            .toList(),
        removedVariantImageUrls: formData.removedVariantImageUrls,
        existingProduct: existingProduct,
      ),
    );
    return null;
  }
}

/// Raw text values captured from the form controllers, passed to
/// [ProductFormCubit.validateAndSubmit] for parsing into save params.
class ProductFormInput {
  final String name;
  final String description;
  final String collection;
  final String sellingPrice;
  final String discountPercentage;
  final String discountValue;

  const ProductFormInput({
    required this.name,
    required this.description,
    required this.collection,
    required this.sellingPrice,
    required this.discountPercentage,
    required this.discountValue,
  });
}
