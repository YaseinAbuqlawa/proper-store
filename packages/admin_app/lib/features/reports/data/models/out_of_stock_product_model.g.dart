// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_of_stock_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OutOfStockProductModel _$OutOfStockProductModelFromJson(
  Map<String, dynamic> json,
) => _OutOfStockProductModel(
  productId: json['id'] as String,
  name: json['name'] as String,
  outOfStockVariants:
      (json['outOfStockVariants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mainImageUrl: json['mainImageUrl'] as String?,
);

Map<String, dynamic> _$OutOfStockProductModelToJson(
  _OutOfStockProductModel instance,
) => <String, dynamic>{
  'id': instance.productId,
  'name': instance.name,
  'outOfStockVariants': instance.outOfStockVariants,
  'mainImageUrl': instance.mainImageUrl,
};
