// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_selling_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopSellingItemModel {

 String get id; String get productId; String get productName; String get variantKey; String get variantName; String get imageUrl; int get totalSold; int get totalRefunded;
/// Create a copy of TopSellingItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopSellingItemModelCopyWith<TopSellingItemModel> get copyWith => _$TopSellingItemModelCopyWithImpl<TopSellingItemModel>(this as TopSellingItemModel, _$identity);

  /// Serializes this TopSellingItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopSellingItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.variantKey, variantKey) || other.variantKey == variantKey)&&(identical(other.variantName, variantName) || other.variantName == variantName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.totalSold, totalSold) || other.totalSold == totalSold)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,variantKey,variantName,imageUrl,totalSold,totalRefunded);

@override
String toString() {
  return 'TopSellingItemModel(id: $id, productId: $productId, productName: $productName, variantKey: $variantKey, variantName: $variantName, imageUrl: $imageUrl, totalSold: $totalSold, totalRefunded: $totalRefunded)';
}


}

/// @nodoc
abstract mixin class $TopSellingItemModelCopyWith<$Res>  {
  factory $TopSellingItemModelCopyWith(TopSellingItemModel value, $Res Function(TopSellingItemModel) _then) = _$TopSellingItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String productName, String variantKey, String variantName, String imageUrl, int totalSold, int totalRefunded
});




}
/// @nodoc
class _$TopSellingItemModelCopyWithImpl<$Res>
    implements $TopSellingItemModelCopyWith<$Res> {
  _$TopSellingItemModelCopyWithImpl(this._self, this._then);

  final TopSellingItemModel _self;
  final $Res Function(TopSellingItemModel) _then;

/// Create a copy of TopSellingItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? variantKey = null,Object? variantName = null,Object? imageUrl = null,Object? totalSold = null,Object? totalRefunded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,variantKey: null == variantKey ? _self.variantKey : variantKey // ignore: cast_nullable_to_non_nullable
as String,variantName: null == variantName ? _self.variantName : variantName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,totalSold: null == totalSold ? _self.totalSold : totalSold // ignore: cast_nullable_to_non_nullable
as int,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopSellingItemModel].
extension TopSellingItemModelPatterns on TopSellingItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopSellingItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopSellingItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopSellingItemModel value)  $default,){
final _that = this;
switch (_that) {
case _TopSellingItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopSellingItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _TopSellingItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String variantKey,  String variantName,  String imageUrl,  int totalSold,  int totalRefunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopSellingItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.variantKey,_that.variantName,_that.imageUrl,_that.totalSold,_that.totalRefunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String productName,  String variantKey,  String variantName,  String imageUrl,  int totalSold,  int totalRefunded)  $default,) {final _that = this;
switch (_that) {
case _TopSellingItemModel():
return $default(_that.id,_that.productId,_that.productName,_that.variantKey,_that.variantName,_that.imageUrl,_that.totalSold,_that.totalRefunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String productName,  String variantKey,  String variantName,  String imageUrl,  int totalSold,  int totalRefunded)?  $default,) {final _that = this;
switch (_that) {
case _TopSellingItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.variantKey,_that.variantName,_that.imageUrl,_that.totalSold,_that.totalRefunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopSellingItemModel extends TopSellingItemModel {
  const _TopSellingItemModel({required this.id, required this.productId, required this.productName, required this.variantKey, required this.variantName, required this.imageUrl, required this.totalSold, this.totalRefunded = 0}): super._();
  factory _TopSellingItemModel.fromJson(Map<String, dynamic> json) => _$TopSellingItemModelFromJson(json);

@override final  String id;
@override final  String productId;
@override final  String productName;
@override final  String variantKey;
@override final  String variantName;
@override final  String imageUrl;
@override final  int totalSold;
@override@JsonKey() final  int totalRefunded;

/// Create a copy of TopSellingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopSellingItemModelCopyWith<_TopSellingItemModel> get copyWith => __$TopSellingItemModelCopyWithImpl<_TopSellingItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopSellingItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopSellingItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.variantKey, variantKey) || other.variantKey == variantKey)&&(identical(other.variantName, variantName) || other.variantName == variantName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.totalSold, totalSold) || other.totalSold == totalSold)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,variantKey,variantName,imageUrl,totalSold,totalRefunded);

@override
String toString() {
  return 'TopSellingItemModel(id: $id, productId: $productId, productName: $productName, variantKey: $variantKey, variantName: $variantName, imageUrl: $imageUrl, totalSold: $totalSold, totalRefunded: $totalRefunded)';
}


}

/// @nodoc
abstract mixin class _$TopSellingItemModelCopyWith<$Res> implements $TopSellingItemModelCopyWith<$Res> {
  factory _$TopSellingItemModelCopyWith(_TopSellingItemModel value, $Res Function(_TopSellingItemModel) _then) = __$TopSellingItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String productName, String variantKey, String variantName, String imageUrl, int totalSold, int totalRefunded
});




}
/// @nodoc
class __$TopSellingItemModelCopyWithImpl<$Res>
    implements _$TopSellingItemModelCopyWith<$Res> {
  __$TopSellingItemModelCopyWithImpl(this._self, this._then);

  final _TopSellingItemModel _self;
  final $Res Function(_TopSellingItemModel) _then;

/// Create a copy of TopSellingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? variantKey = null,Object? variantName = null,Object? imageUrl = null,Object? totalSold = null,Object? totalRefunded = null,}) {
  return _then(_TopSellingItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,variantKey: null == variantKey ? _self.variantKey : variantKey // ignore: cast_nullable_to_non_nullable
as String,variantName: null == variantName ? _self.variantName : variantName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,totalSold: null == totalSold ? _self.totalSold : totalSold // ignore: cast_nullable_to_non_nullable
as int,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
