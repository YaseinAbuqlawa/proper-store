// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_spender_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopSpenderModel {

 String get customerId; String get name; double get totalSpent; int get orderCount; int get refundCount;
/// Create a copy of TopSpenderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopSpenderModelCopyWith<TopSpenderModel> get copyWith => _$TopSpenderModelCopyWithImpl<TopSpenderModel>(this as TopSpenderModel, _$identity);

  /// Serializes this TopSpenderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopSpenderModel&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.refundCount, refundCount) || other.refundCount == refundCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,name,totalSpent,orderCount,refundCount);

@override
String toString() {
  return 'TopSpenderModel(customerId: $customerId, name: $name, totalSpent: $totalSpent, orderCount: $orderCount, refundCount: $refundCount)';
}


}

/// @nodoc
abstract mixin class $TopSpenderModelCopyWith<$Res>  {
  factory $TopSpenderModelCopyWith(TopSpenderModel value, $Res Function(TopSpenderModel) _then) = _$TopSpenderModelCopyWithImpl;
@useResult
$Res call({
 String customerId, String name, double totalSpent, int orderCount, int refundCount
});




}
/// @nodoc
class _$TopSpenderModelCopyWithImpl<$Res>
    implements $TopSpenderModelCopyWith<$Res> {
  _$TopSpenderModelCopyWithImpl(this._self, this._then);

  final TopSpenderModel _self;
  final $Res Function(TopSpenderModel) _then;

/// Create a copy of TopSpenderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = null,Object? name = null,Object? totalSpent = null,Object? orderCount = null,Object? refundCount = null,}) {
  return _then(_self.copyWith(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,orderCount: null == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int,refundCount: null == refundCount ? _self.refundCount : refundCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopSpenderModel].
extension TopSpenderModelPatterns on TopSpenderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopSpenderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopSpenderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopSpenderModel value)  $default,){
final _that = this;
switch (_that) {
case _TopSpenderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopSpenderModel value)?  $default,){
final _that = this;
switch (_that) {
case _TopSpenderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String customerId,  String name,  double totalSpent,  int orderCount,  int refundCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopSpenderModel() when $default != null:
return $default(_that.customerId,_that.name,_that.totalSpent,_that.orderCount,_that.refundCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String customerId,  String name,  double totalSpent,  int orderCount,  int refundCount)  $default,) {final _that = this;
switch (_that) {
case _TopSpenderModel():
return $default(_that.customerId,_that.name,_that.totalSpent,_that.orderCount,_that.refundCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String customerId,  String name,  double totalSpent,  int orderCount,  int refundCount)?  $default,) {final _that = this;
switch (_that) {
case _TopSpenderModel() when $default != null:
return $default(_that.customerId,_that.name,_that.totalSpent,_that.orderCount,_that.refundCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopSpenderModel extends TopSpenderModel {
  const _TopSpenderModel({required this.customerId, required this.name, required this.totalSpent, required this.orderCount, this.refundCount = 0}): super._();
  factory _TopSpenderModel.fromJson(Map<String, dynamic> json) => _$TopSpenderModelFromJson(json);

@override final  String customerId;
@override final  String name;
@override final  double totalSpent;
@override final  int orderCount;
@override@JsonKey() final  int refundCount;

/// Create a copy of TopSpenderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopSpenderModelCopyWith<_TopSpenderModel> get copyWith => __$TopSpenderModelCopyWithImpl<_TopSpenderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopSpenderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopSpenderModel&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.refundCount, refundCount) || other.refundCount == refundCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,name,totalSpent,orderCount,refundCount);

@override
String toString() {
  return 'TopSpenderModel(customerId: $customerId, name: $name, totalSpent: $totalSpent, orderCount: $orderCount, refundCount: $refundCount)';
}


}

/// @nodoc
abstract mixin class _$TopSpenderModelCopyWith<$Res> implements $TopSpenderModelCopyWith<$Res> {
  factory _$TopSpenderModelCopyWith(_TopSpenderModel value, $Res Function(_TopSpenderModel) _then) = __$TopSpenderModelCopyWithImpl;
@override @useResult
$Res call({
 String customerId, String name, double totalSpent, int orderCount, int refundCount
});




}
/// @nodoc
class __$TopSpenderModelCopyWithImpl<$Res>
    implements _$TopSpenderModelCopyWith<$Res> {
  __$TopSpenderModelCopyWithImpl(this._self, this._then);

  final _TopSpenderModel _self;
  final $Res Function(_TopSpenderModel) _then;

/// Create a copy of TopSpenderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? name = null,Object? totalSpent = null,Object? orderCount = null,Object? refundCount = null,}) {
  return _then(_TopSpenderModel(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,orderCount: null == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int,refundCount: null == refundCount ? _self.refundCount : refundCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
