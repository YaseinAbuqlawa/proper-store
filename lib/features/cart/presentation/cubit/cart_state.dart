part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    required CartStates cartState,
    @Default([]) List<ProductModel> products,
  }) = _CartState;
}

enum CartStates { initial, loading, success, failure }
