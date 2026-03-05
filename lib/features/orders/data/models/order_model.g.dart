// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  products: (json['products'] as List<dynamic>)
      .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPrice: (json['totalPrice'] as num).toDouble(),
  discountTotal: (json['discountTotal'] as num).toDouble(),
  netTotal: (json['netTotal'] as num).toDouble(),
  shippingAddress: AddressModel.fromJson(
    json['shippingAddress'] as Map<String, dynamic>,
  ),
  status: json['status'] == null
      ? OrderStatus.pending
      : _statusFromJson(json['status']),
  createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
  paymentMethod: json['paymentMethod'] as String? ?? 'COD',
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'discountTotal': instance.discountTotal,
      'netTotal': instance.netTotal,
      'shippingAddress': instance.shippingAddress,
      'status': _statusToJson(instance.status),
      'createdAt': instance.createdAt,
      'paymentMethod': instance.paymentMethod,
    };
