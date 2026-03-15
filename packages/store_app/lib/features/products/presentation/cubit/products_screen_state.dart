part of 'products_screen_cubit.dart';

@freezed
abstract class ProductsScreenState with _$ProductsScreenState {
  const factory ProductsScreenState.initial() = _Initial;
  const factory ProductsScreenState.loading() = _Loading;
  const factory ProductsScreenState.paginated({
    required List<ProductModel> products,
    required bool hasMore,
    required bool isLoadingMore,
  }) = _Paginated;
  const factory ProductsScreenState.failure({required String failureMessage}) =
      _Failure;
}
