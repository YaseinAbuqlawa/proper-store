// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      area: json['area'] as String,
      street: json['street'] as String,
      buildingNumber: json['buildingNumber'] as String,
      floor: json['floor'] as String,
      apartment: json['apartment'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'city': instance.city,
      'area': instance.area,
      'street': instance.street,
      'buildingNumber': instance.buildingNumber,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'isDefault': instance.isDefault,
    };
