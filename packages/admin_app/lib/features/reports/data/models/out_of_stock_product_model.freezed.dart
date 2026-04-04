// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'out_of_stock_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutOfStockProductModel {

@JsonKey(name: "id") String get productId; String get name; List<String> get outOfStockVariants; String? get mainImageUrl;
/// Create a copy of OutOfStockProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutOfStockProductModelCopyWith<OutOfStockProductModel> get copyWith => _$OutOfStockProductModelCopyWithImpl<OutOfStockProductModel>(this as OutOfStockProductModel, _$identity);

  /// Serializes this OutOfStockProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutOfStockProductModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.outOfStockVariants, outOfStockVariants)&&(identical(other.mainImageUrl, mainImageUrl) || other.mainImageUrl == mainImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,name,const DeepCollectionEquality().hash(outOfStockVariants),mainImageUrl);

@override
String toString() {
  return 'OutOfStockProductModel(productId: $productId, name: $name, outOfStockVariants: $outOfStockVariants, mainImageUrl: $mainImageUrl)';
}


}

/// @nodoc
abstract mixin class $OutOfStockProductModelCopyWith<$Res>  {
  factory $OutOfStockProductModelCopyWith(OutOfStockProductModel value, $Res Function(OutOfStockProductModel) _then) = _$OutOfStockProductModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") String productId, String name, List<String> outOfStockVariants, String? mainImageUrl
});




}
/// @nodoc
class _$OutOfStockProductModelCopyWithImpl<$Res>
    implements $OutOfStockProductModelCopyWith<$Res> {
  _$OutOfStockProductModelCopyWithImpl(this._self, this._then);

  final OutOfStockProductModel _self;
  final $Res Function(OutOfStockProductModel) _then;

/// Create a copy of OutOfStockProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? outOfStockVariants = null,Object? mainImageUrl = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,outOfStockVariants: null == outOfStockVariants ? _self.outOfStockVariants : outOfStockVariants // ignore: cast_nullable_to_non_nullable
as List<String>,mainImageUrl: freezed == mainImageUrl ? _self.mainImageUrl : mainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutOfStockProductModel].
extension OutOfStockProductModelPatterns on OutOfStockProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutOfStockProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutOfStockProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutOfStockProductModel value)  $default,){
final _that = this;
switch (_that) {
case _OutOfStockProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutOfStockProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _OutOfStockProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String productId,  String name,  List<String> outOfStockVariants,  String? mainImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutOfStockProductModel() when $default != null:
return $default(_that.productId,_that.name,_that.outOfStockVariants,_that.mainImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String productId,  String name,  List<String> outOfStockVariants,  String? mainImageUrl)  $default,) {final _that = this;
switch (_that) {
case _OutOfStockProductModel():
return $default(_that.productId,_that.name,_that.outOfStockVariants,_that.mainImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  String productId,  String name,  List<String> outOfStockVariants,  String? mainImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _OutOfStockProductModel() when $default != null:
return $default(_that.productId,_that.name,_that.outOfStockVariants,_that.mainImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutOfStockProductModel extends OutOfStockProductModel {
  const _OutOfStockProductModel({@JsonKey(name: "id") required this.productId, required this.name, final  List<String> outOfStockVariants = const [], this.mainImageUrl}): _outOfStockVariants = outOfStockVariants,super._();
  factory _OutOfStockProductModel.fromJson(Map<String, dynamic> json) => _$OutOfStockProductModelFromJson(json);

@override@JsonKey(name: "id") final  String productId;
@override final  String name;
 final  List<String> _outOfStockVariants;
@override@JsonKey() List<String> get outOfStockVariants {
  if (_outOfStockVariants is EqualUnmodifiableListView) return _outOfStockVariants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outOfStockVariants);
}

@override final  String? mainImageUrl;

/// Create a copy of OutOfStockProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutOfStockProductModelCopyWith<_OutOfStockProductModel> get copyWith => __$OutOfStockProductModelCopyWithImpl<_OutOfStockProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutOfStockProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutOfStockProductModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._outOfStockVariants, _outOfStockVariants)&&(identical(other.mainImageUrl, mainImageUrl) || other.mainImageUrl == mainImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,name,const DeepCollectionEquality().hash(_outOfStockVariants),mainImageUrl);

@override
String toString() {
  return 'OutOfStockProductModel(productId: $productId, name: $name, outOfStockVariants: $outOfStockVariants, mainImageUrl: $mainImageUrl)';
}


}

/// @nodoc
abstract mixin class _$OutOfStockProductModelCopyWith<$Res> implements $OutOfStockProductModelCopyWith<$Res> {
  factory _$OutOfStockProductModelCopyWith(_OutOfStockProductModel value, $Res Function(_OutOfStockProductModel) _then) = __$OutOfStockProductModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") String productId, String name, List<String> outOfStockVariants, String? mainImageUrl
});




}
/// @nodoc
class __$OutOfStockProductModelCopyWithImpl<$Res>
    implements _$OutOfStockProductModelCopyWith<$Res> {
  __$OutOfStockProductModelCopyWithImpl(this._self, this._then);

  final _OutOfStockProductModel _self;
  final $Res Function(_OutOfStockProductModel) _then;

/// Create a copy of OutOfStockProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? outOfStockVariants = null,Object? mainImageUrl = freezed,}) {
  return _then(_OutOfStockProductModel(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,outOfStockVariants: null == outOfStockVariants ? _self._outOfStockVariants : outOfStockVariants // ignore: cast_nullable_to_non_nullable
as List<String>,mainImageUrl: freezed == mainImageUrl ? _self.mainImageUrl : mainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
