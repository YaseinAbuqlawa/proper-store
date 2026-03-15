// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesState implements DiagnosticableTreeMixin {

 List<ProductModel> get favoriteProducts; String get failureMessage;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FavoritesState'))
    ..add(DiagnosticsProperty('favoriteProducts', favoriteProducts))..add(DiagnosticsProperty('failureMessage', failureMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&const DeepCollectionEquality().equals(other.favoriteProducts, favoriteProducts)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favoriteProducts),failureMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FavoritesState(favoriteProducts: $favoriteProducts, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> favoriteProducts, String failureMessage
});




}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteProducts = null,Object? failureMessage = null,}) {
  return _then(_self.copyWith(
favoriteProducts: null == favoriteProducts ? _self.favoriteProducts : favoriteProducts // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,failureMessage: null == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesState value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductModel> favoriteProducts,  String failureMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.favoriteProducts,_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductModel> favoriteProducts,  String failureMessage)  $default,) {final _that = this;
switch (_that) {
case _FavoritesState():
return $default(_that.favoriteProducts,_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductModel> favoriteProducts,  String failureMessage)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.favoriteProducts,_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FavoritesState with DiagnosticableTreeMixin implements FavoritesState {
  const _FavoritesState({required final  List<ProductModel> favoriteProducts, this.failureMessage = ""}): _favoriteProducts = favoriteProducts;
  

 final  List<ProductModel> _favoriteProducts;
@override List<ProductModel> get favoriteProducts {
  if (_favoriteProducts is EqualUnmodifiableListView) return _favoriteProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteProducts);
}

@override@JsonKey() final  String failureMessage;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FavoritesState'))
    ..add(DiagnosticsProperty('favoriteProducts', favoriteProducts))..add(DiagnosticsProperty('failureMessage', failureMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&const DeepCollectionEquality().equals(other._favoriteProducts, _favoriteProducts)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favoriteProducts),failureMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FavoritesState(favoriteProducts: $favoriteProducts, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProductModel> favoriteProducts, String failureMessage
});




}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteProducts = null,Object? failureMessage = null,}) {
  return _then(_FavoritesState(
favoriteProducts: null == favoriteProducts ? _self._favoriteProducts : favoriteProducts // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,failureMessage: null == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
