import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/color_option.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/domain/use_cases/get_product_with_id_use_case.dart';
import 'package:proper_store/features/product_details/domain/use_cases/get_related_products_use_case.dart';

part 'product_details_cubit.freezed.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductWithIdUseCase getProductWithIdUseCase;
  final GetRelatedProductsUseCase getRelatedProductsUseCase;
  ProductDetailsCubit({
    required this.getProductWithIdUseCase,
    required this.getRelatedProductsUseCase,
  }) : super(ProductDetailsState.initial());

  void selectColor(ColorOption selectedColor) {
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

    //? wait for the hero animation
    await Future.delayed(Duration(milliseconds: 500));
    if (isClosed) return;
    result.fold(
      (serverFailure) =>
          emit(ProductDetailsState.failure(code: serverFailure.code)),
      (productDetails) async {
        final result = await getRelatedProducts(
          productCategory: productDetails.category,
          currentProductId: productDetails.id,
        );
        result.fold(
          (serverFailure) =>
              emit(ProductDetailsState.failure(code: serverFailure.code)),
          (relatedProductsList) => emit(
            ProductDetailsState.success(
              productDetails: productDetails,
              relatedProductsList: relatedProductsList,
            ),
          ),
        );
      },
    );
  }

  Future<Either<ServerFailure, List<ProductModel>>> getRelatedProducts({
    required String productCategory,
    required String currentProductId,
  }) async {
    final result = await getRelatedProductsUseCase.call(
      productCategory: productCategory,
      currentProductId: currentProductId,
    );

    return result.fold(
      (serverFailure) => Left(serverFailure),
      (relatedProductsList) => Right(relatedProductsList),
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
