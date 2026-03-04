// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_collection_banner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeCollectionBannerModel {

 String get description; String get badgeText; String get imageUrl; String get title;
/// Create a copy of HomeCollectionBannerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeCollectionBannerModelCopyWith<HomeCollectionBannerModel> get copyWith => _$HomeCollectionBannerModelCopyWithImpl<HomeCollectionBannerModel>(this as HomeCollectionBannerModel, _$identity);

  /// Serializes this HomeCollectionBannerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCollectionBannerModel&&(identical(other.description, description) || other.description == description)&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,badgeText,imageUrl,title);

@override
String toString() {
  return 'HomeCollectionBannerModel(description: $description, badgeText: $badgeText, imageUrl: $imageUrl, title: $title)';
}


}

/// @nodoc
abstract mixin class $HomeCollectionBannerModelCopyWith<$Res>  {
  factory $HomeCollectionBannerModelCopyWith(HomeCollectionBannerModel value, $Res Function(HomeCollectionBannerModel) _then) = _$HomeCollectionBannerModelCopyWithImpl;
@useResult
$Res call({
 String description, String badgeText, String imageUrl, String title
});




}
/// @nodoc
class _$HomeCollectionBannerModelCopyWithImpl<$Res>
    implements $HomeCollectionBannerModelCopyWith<$Res> {
  _$HomeCollectionBannerModelCopyWithImpl(this._self, this._then);

  final HomeCollectionBannerModel _self;
  final $Res Function(HomeCollectionBannerModel) _then;

/// Create a copy of HomeCollectionBannerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? badgeText = null,Object? imageUrl = null,Object? title = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeCollectionBannerModel].
extension HomeCollectionBannerModelPatterns on HomeCollectionBannerModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeCollectionBannerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeCollectionBannerModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeCollectionBannerModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeCollectionBannerModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeCollectionBannerModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeCollectionBannerModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  String badgeText,  String imageUrl,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeCollectionBannerModel() when $default != null:
return $default(_that.description,_that.badgeText,_that.imageUrl,_that.title);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  String badgeText,  String imageUrl,  String title)  $default,) {final _that = this;
switch (_that) {
case _HomeCollectionBannerModel():
return $default(_that.description,_that.badgeText,_that.imageUrl,_that.title);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  String badgeText,  String imageUrl,  String title)?  $default,) {final _that = this;
switch (_that) {
case _HomeCollectionBannerModel() when $default != null:
return $default(_that.description,_that.badgeText,_that.imageUrl,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeCollectionBannerModel implements HomeCollectionBannerModel {
  const _HomeCollectionBannerModel({required this.description, required this.badgeText, required this.imageUrl, required this.title});
  factory _HomeCollectionBannerModel.fromJson(Map<String, dynamic> json) => _$HomeCollectionBannerModelFromJson(json);

@override final  String description;
@override final  String badgeText;
@override final  String imageUrl;
@override final  String title;

/// Create a copy of HomeCollectionBannerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeCollectionBannerModelCopyWith<_HomeCollectionBannerModel> get copyWith => __$HomeCollectionBannerModelCopyWithImpl<_HomeCollectionBannerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeCollectionBannerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeCollectionBannerModel&&(identical(other.description, description) || other.description == description)&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,badgeText,imageUrl,title);

@override
String toString() {
  return 'HomeCollectionBannerModel(description: $description, badgeText: $badgeText, imageUrl: $imageUrl, title: $title)';
}


}

/// @nodoc
abstract mixin class _$HomeCollectionBannerModelCopyWith<$Res> implements $HomeCollectionBannerModelCopyWith<$Res> {
  factory _$HomeCollectionBannerModelCopyWith(_HomeCollectionBannerModel value, $Res Function(_HomeCollectionBannerModel) _then) = __$HomeCollectionBannerModelCopyWithImpl;
@override @useResult
$Res call({
 String description, String badgeText, String imageUrl, String title
});




}
/// @nodoc
class __$HomeCollectionBannerModelCopyWithImpl<$Res>
    implements _$HomeCollectionBannerModelCopyWith<$Res> {
  __$HomeCollectionBannerModelCopyWithImpl(this._self, this._then);

  final _HomeCollectionBannerModel _self;
  final $Res Function(_HomeCollectionBannerModel) _then;

/// Create a copy of HomeCollectionBannerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? badgeText = null,Object? imageUrl = null,Object? title = null,}) {
  return _then(_HomeCollectionBannerModel(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
