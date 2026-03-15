// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_collection_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeCollectionBannerModel _$HomeCollectionBannerModelFromJson(
  Map<String, dynamic> json,
) => _HomeCollectionBannerModel(
  description: json['description'] as String,
  badgeText: json['badgeText'] as String,
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String,
  collection: json['collection'] as String? ?? null,
);

Map<String, dynamic> _$HomeCollectionBannerModelToJson(
  _HomeCollectionBannerModel instance,
) => <String, dynamic>{
  'description': instance.description,
  'badgeText': instance.badgeText,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'collection': instance.collection,
};
