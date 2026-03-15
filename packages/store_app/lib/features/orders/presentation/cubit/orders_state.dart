import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:proper_store_shared/models/order_model.dart';

part 'orders_state.freezed.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.loaded({required List<OrderModel> orders}) = _Loaded;
  const factory OrdersState.failure({required String failureMessage}) = _Failure;
}
