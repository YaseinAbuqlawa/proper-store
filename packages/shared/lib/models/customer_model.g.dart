// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    _CustomerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      favoritesList:
          (json['favoritesList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      role: json['role'] as String? ?? null,
      phone: json['phone'] as String? ?? '',
      cartItems:
          (json['cartItems'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CustomerModelToJson(_CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'favoritesList': instance.favoritesList,
      'role': instance.role,
      'phone': instance.phone,
      'cartItems': instance.cartItems,
    };
