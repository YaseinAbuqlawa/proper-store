// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_spender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopSpenderModel _$TopSpenderModelFromJson(Map<String, dynamic> json) =>
    _TopSpenderModel(
      customerId: json['customerId'] as String,
      name: json['name'] as String,
      totalSpent: (json['totalSpent'] as num).toDouble(),
      orderCount: (json['orderCount'] as num).toInt(),
    );

Map<String, dynamic> _$TopSpenderModelToJson(_TopSpenderModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'name': instance.name,
      'totalSpent': instance.totalSpent,
      'orderCount': instance.orderCount,
    };
