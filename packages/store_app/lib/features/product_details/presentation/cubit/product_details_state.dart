part of 'product_details_cubit.dart';

@freezed
abstract class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = _Loading;
  const factory ProductDetailsState.success({
    @Default(null) ProductModel? productDetails,
    @Default(0) int activeIndex,
    @Default([]) List<ProductModel> relatedProductsList,
  }) = _Success;
  const factory ProductDetailsState.failure({required String code}) = _Failure;
}
