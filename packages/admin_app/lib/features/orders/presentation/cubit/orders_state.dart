import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store_shared/models/order_model.dart';

part 'orders_state.freezed.dart';

enum OrdersStatus { initial, loading, loaded, loadingMore, failure }

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(OrdersStatus.initial) OrdersStatus status,
    @Default([]) List<OrderModel> orders,
    @Default(true) bool hasMore,
    DocumentSnapshot? lastDoc,
    @Default('') String failureMessage,
    @Default(null) OrderStatus? activeFilter,
    @Default(null) String? customerIdFilter,
  }) = _OrdersState;
}
