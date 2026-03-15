part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStates.initial) HomeStates bannerState,
    @Default(HomeStates.initial) HomeStates productsState,
    @Default(HomeStates.initial) HomeStates categoriesState,
    @Default('') String failureCode,
    @Default(dummyBanner) HomeCollectionBannerModel homeCollectionBannerModel,
    @Default([]) List<CategoryModel> bagCategoriesList,
    @Default([]) List<ProductModel> mostSoldProductsList,
  }) = _HomeState;
}

const dummyBanner = HomeCollectionBannerModel(
  title: 'جودة عالية وأسعار لا تقاوم',
  description: 'اكتشفي تشكيلتنا الجديدة من الحقائب والأحذية...',
  imageUrl: '',
  badgeText: 'كوليكشن العيد',
);

enum HomeStates { initial, loading, success, failure }
