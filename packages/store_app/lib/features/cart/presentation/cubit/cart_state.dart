part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    required CartStates cartState,
    @Default([]) List<CartItemModel> products,
    @Default(null) String? errorMessage,
  }) = _CartState;
}

enum CartStates { initial, loading, success, failure }
