// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeCollectionBannerModel {
  final String description;
  final DateTime endDate;
  final String badgeText;
  final String imageUrl;
  final String title;

  const HomeCollectionBannerModel(
    this.description,
    this.endDate,
    this.badgeText,
    this.imageUrl,
    this.title,
  );

  HomeCollectionBannerModel copyWith({
    String? description,
    DateTime? endDate,
    String? badgeText,
    String? imageUrl,
    String? title,
  }) {
    return HomeCollectionBannerModel(
      description ?? this.description,
      endDate ?? this.endDate,
      badgeText ?? this.badgeText,
      imageUrl ?? this.imageUrl,
      title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'endDate': endDate.millisecondsSinceEpoch,
      'badgeText': badgeText,
      'imageUrl': imageUrl,
      'title': title,
    };
  }

  factory HomeCollectionBannerModel.fromMap(Map<String, dynamic> map) {
    return HomeCollectionBannerModel(
      map['description'] as String,
      map['offerEndTime'].toDate(),
      map['badgeText'] as String,
      map['imageUrl'] as String,
      map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeCollectionBannerModel.fromJson(String source) =>
      HomeCollectionBannerModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'HomeCollectionBannerModel(description: $description, endDate: $endDate, badgeText: $badgeText, imageUrl: $imageUrl, title: $title)';
  }

  @override
  bool operator ==(covariant HomeCollectionBannerModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.endDate == endDate &&
        other.badgeText == badgeText &&
        other.imageUrl == imageUrl &&
        other.title == title;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        endDate.hashCode ^
        badgeText.hashCode ^
        imageUrl.hashCode ^
        title.hashCode;
  }
}
