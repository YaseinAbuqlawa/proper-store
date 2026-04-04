// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_selling_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopSellingItemModel _$TopSellingItemModelFromJson(Map<String, dynamic> json) =>
    _TopSellingItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      variantKey: json['variantKey'] as String,
      variantName: json['variantName'] as String,
      imageUrl: json['imageUrl'] as String,
      totalSold: (json['totalSold'] as num).toInt(),
    );

Map<String, dynamic> _$TopSellingItemModelToJson(
  _TopSellingItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'productName': instance.productName,
  'variantKey': instance.variantKey,
  'variantName': instance.variantName,
  'imageUrl': instance.imageUrl,
  'totalSold': instance.totalSold,
};
