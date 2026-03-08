part of 'products_screen_cubit.dart';

@freezed
abstract class ProductsScreenState with _$ProductsScreenState {
  const factory ProductsScreenState.initial() = _Initial;
  const factory ProductsScreenState.loading() = _Loading;
  const factory ProductsScreenState.success({
    required List<ProductModel> products,
  }) = _Success;
  const factory ProductsScreenState.failure({required String failureMessage}) =
      _Failure;
}
