import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/domain/use_cases/get_product_with_id_use_case.dart';
import 'package:proper_store/features/product_details/domain/use_cases/build_cart_item_use_case.dart';
import 'package:proper_store/features/product_details/domain/use_cases/get_related_products_use_case.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

part 'product_details_cubit.freezed.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductWithIdUseCase getProductWithIdUseCase;
  final GetRelatedProductsUseCase getRelatedProductsUseCase;
  final BuildCartItemUseCase buildCartItemUseCase;
  final FirebaseAuth firebaseAuth;

  ProductDetailsCubit({
    required this.getProductWithIdUseCase,
    required this.getRelatedProductsUseCase,
    required this.buildCartItemUseCase,
    required this.firebaseAuth,
  }) : super(ProductDetailsState.initial());

  bool get needsAuth => firebaseAuth.currentUser == null;

  CartItemModel? buildCartItem() {
    return state.maybeWhen(
      success: (product, _, _) =>
          product != null ? buildCartItemUseCase(product) : null,
      orElse: () => null,
    );
  }

  void selectColor(ProductVariant selectedColor) {
    state.whenOrNull(
      success: (productDetails, activeIndex, relatedProductsList) => emit(
        ProductDetailsState.success(
          productDetails: productDetails!.copyWith(
            selectedColor: selectedColor,
          ),
          activeIndex: activeIndex,
          relatedProductsList: relatedProductsList,
        ),
      ),
    );
  }

  void setProduct(ProductModel product) {
    emit(ProductDetailsState.success(productDetails: product));
  }

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsState.loading());
    final result = await getProductWithIdUseCase.call(productId);
    if (isClosed) return;
    result.fold(
      (serverFailure) =>
          emit(ProductDetailsState.failure(code: serverFailure.code)),
      (productDetails) async {
        final relatedResult = await _getRelatedProducts(
          productCategory: productDetails.category,
          currentProductId: productDetails.id,
        );
        if (isClosed) return;
        // Related products failure is non-critical — show product regardless.
        final relatedList = relatedResult.getOrElse((_) => []);
        emit(
          ProductDetailsState.success(
            productDetails: productDetails.copyWith(
              selectedColor: productDetails.variants.values.firstOrNull,
            ),
            relatedProductsList: relatedList,
          ),
        );
      },
    );
  }

  Future<Either<ServerFailure, List<ProductModel>>> _getRelatedProducts({
    required String productCategory,
    required String currentProductId,
  }) async {
    return getRelatedProductsUseCase.call(
      productCategory: productCategory,
      currentProductId: currentProductId,
    );
  }

  void setActiveIndex(int index) {
    state.whenOrNull(
      success: (productDetails, activeIndex, relatedProductsList) => emit(
        ProductDetailsState.success(
          productDetails: productDetails,
          activeIndex: index,
        ),
      ),
    );
  }
}
