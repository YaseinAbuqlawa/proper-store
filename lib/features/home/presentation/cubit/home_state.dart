part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStates.initial) HomeStates bannerState,
    @Default(HomeStates.initial) HomeStates productsState,
    @Default('') String failureCode,
    HomeCollectionBannerModel? homeCollectionBannerModel,
    @Default([]) List<ProductModel> mostSoldProductsList,
  }) = _HomeState;
}

enum HomeStates { initial, loading, success, failure }
