part of 'store_config_cubit.dart';

@freezed
sealed class StoreConfigState with _$StoreConfigState {
  const factory StoreConfigState.initial() = _Initial;
  const factory StoreConfigState.loading() = _Loading;
  const factory StoreConfigState.loaded({
    required Map<String, double> shippingCosts,
    required List<CategoryModel> categories,
    required HomeCollectionBannerModel? banner,
    @Default(false) bool isSavingShipping,
    @Default(false) bool isSavingCategory,
    @Default(false) bool isSavingBanner,
  }) = StoreConfigLoaded;
  const factory StoreConfigState.failure({required String message}) = _Failure;
}
