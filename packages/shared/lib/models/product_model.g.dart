// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      category: json['category'] as String,
      variants: const ProductVariantMapConverter().fromJson(
        json['variants'] as Map<String, dynamic>,
      ),
      description: json['description'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      discountValue: (json['discountValue'] as num).toDouble(),
      id: json['id'] as String,
      mainImageUrl: json['mainImageUrl'] as String,
      lastPurchaseDate: const TimestampConverter().fromJson(
        json['lastPurchaseDate'],
      ),
      material: json['material'] as String,
      name: json['name'] as String,
      refundedQuantity: (json['refundedQuantity'] as num).toInt(),
      collection: json['collection'] as String? ?? "",
      section: json['section'] as String,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      shippedQuantity: (json['shippedQuantity'] as num).toInt(),
      totalStock: (json['totalStock'] as num?)?.toInt() ?? 0,
      outOfStockVariants:
          (json['outOfStockVariants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasOutOfStockVariants: json['hasOutOfStockVariants'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'variants': const ProductVariantMapConverter().toJson(instance.variants),
      'description': instance.description,
      'discountPercentage': instance.discountPercentage,
      'discountValue': instance.discountValue,
      'id': instance.id,
      'mainImageUrl': instance.mainImageUrl,
      'lastPurchaseDate': const TimestampConverter().toJson(
        instance.lastPurchaseDate,
      ),
      'material': instance.material,
      'name': instance.name,
      'refundedQuantity': instance.refundedQuantity,
      'collection': instance.collection,
      'section': instance.section,
      'sellingPrice': instance.sellingPrice,
      'sizes': instance.sizes,
      'shippedQuantity': instance.shippedQuantity,
      'totalStock': instance.totalStock,
      'outOfStockVariants': instance.outOfStockVariants,
      'hasOutOfStockVariants': instance.hasOutOfStockVariants,
    };
