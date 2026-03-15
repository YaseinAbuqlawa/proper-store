import 'package:freezed_annotation/freezed_annotation.dart';

import 'address_model.dart';
import 'cart_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

OrderStatus _statusFromJson(dynamic value) => OrderStatus.values.firstWhere(
  (s) => s.name == value?.toString(),
  orElse: () => OrderStatus.pending,
);

String _statusToJson(OrderStatus status) => status.name;

@freezed
abstract class OrderModel with _$OrderModel {
  const OrderModel._();

  const factory OrderModel({
    required String id,
    required String customerId,
    required List<CartItemModel> products,
    required double totalPrice,
    required double discountTotal,
    required double netTotal,
    required AddressModel shippingAddress,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    @Default(OrderStatus.pending)
    OrderStatus status,
    @Default(0) int createdAt,
    @Default('COD') String paymentMethod,
    @Default(0.0) double shippingCost,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  DateTime get createdAtDate =>
      DateTime.fromMillisecondsSinceEpoch(createdAt);

  double get grandTotal => netTotal + shippingCost;
}
