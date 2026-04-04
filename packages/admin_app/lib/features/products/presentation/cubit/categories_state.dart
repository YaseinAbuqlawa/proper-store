part of 'categories_cubit.dart';

enum CategoriesStatus { initial, loading, success, failure }

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(CategoriesStatus.initial) CategoriesStatus status,
    @Default([]) List<String> categories,
    ServerFailure? failure,
  }) = _CategoriesState;
}
