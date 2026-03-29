// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      variantKey: json['variantKey'] as String,
      name: json['name'] as String,
      selectedColor: const ColorConverter().fromJson(
        (json['selectedColor'] as num).toInt(),
      ),
      imageUrl: json['imageUrl'] as String,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      discountValue: (json['discountValue'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'variantKey': instance.variantKey,
      'name': instance.name,
      'selectedColor': const ColorConverter().toJson(instance.selectedColor),
      'imageUrl': instance.imageUrl,
      'sellingPrice': instance.sellingPrice,
      'discountValue': instance.discountValue,
      'quantity': instance.quantity,
    };
