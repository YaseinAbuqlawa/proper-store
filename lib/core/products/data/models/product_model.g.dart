// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      category: json['category'] as String,
      colors: (json['colors'] as List<dynamic>)
          .map(
            (e) => const ColorOptionConverter().fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      selectedColor:
          _$JsonConverterFromJson<Map<String, dynamic>, ColorOption>(
            json['selectedColor'],
            const ColorOptionConverter().fromJson,
          ) ??
          null,
      description: json['description'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      discountValue: (json['discountValue'] as num).toDouble(),
      id: json['id'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastPurchaseDate: const TimestampConverter().fromJson(
        json['lastPurchaseDate'],
      ),
      material: json['material'] as String,
      name: json['name'] as String,
      refundedQuantity: (json['refundedQuantity'] as num).toInt(),
      section: json['section'] as String,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      soldQuantity: (json['soldQuantity'] as num).toInt(),
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      videoUrls: (json['videoUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(
  _ProductModel instance,
) => <String, dynamic>{
  'category': instance.category,
  'colors': instance.colors.map(const ColorOptionConverter().toJson).toList(),
  'selectedColor': _$JsonConverterToJson<Map<String, dynamic>, ColorOption>(
    instance.selectedColor,
    const ColorOptionConverter().toJson,
  ),
  'description': instance.description,
  'discountPercentage': instance.discountPercentage,
  'discountValue': instance.discountValue,
  'id': instance.id,
  'imageUrls': instance.imageUrls,
  'lastPurchaseDate': const TimestampConverter().toJson(
    instance.lastPurchaseDate,
  ),
  'material': instance.material,
  'name': instance.name,
  'refundedQuantity': instance.refundedQuantity,
  'section': instance.section,
  'sellingPrice': instance.sellingPrice,
  'sizes': instance.sizes,
  'soldQuantity': instance.soldQuantity,
  'stockQuantity': instance.stockQuantity,
  'videoUrls': instance.videoUrls,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
