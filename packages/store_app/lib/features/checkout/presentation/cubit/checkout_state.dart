part of 'checkout_cubit.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.placing() = _Placing;
  const factory CheckoutState.success({required String orderId}) = _Success;
  const factory CheckoutState.failure({required String failureMessage}) =
      _Failure;
  const factory CheckoutState.outOfStock({
    required String productName,
    required String variantName,
    required int available,
  }) = _OutOfStock;
}
