part of 'favorites_cubit.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    required List<ProductModel> favoriteProducts,
    @Default("") String failureMessage,
  }) = _FavoritesState;
}
