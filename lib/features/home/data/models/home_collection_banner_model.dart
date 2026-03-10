import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_collection_banner_model.freezed.dart';
part 'home_collection_banner_model.g.dart';

@freezed
abstract class HomeCollectionBannerModel with _$HomeCollectionBannerModel {
  const factory HomeCollectionBannerModel({
    required String description,
    required String badgeText,
    required String imageUrl,
    required String title,
    @Default(null) String? collection,
  }) = _HomeCollectionBannerModel;

  factory HomeCollectionBannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomeCollectionBannerModelFromJson(json);
}
