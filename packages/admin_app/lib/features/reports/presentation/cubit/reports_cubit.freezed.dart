// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState()';
}


}

/// @nodoc
class $ReportsStateCopyWith<$Res>  {
$ReportsStateCopyWith(ReportsState _, $Res Function(ReportsState) __);
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ReportsInitial value)?  reportsInitial,TResult Function( _ReportsLoading value)?  reportsLoading,TResult Function( _ReportsLoaded value)?  reportsLoaded,TResult Function( _ReportsFailure value)?  reportsFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsInitial() when reportsInitial != null:
return reportsInitial(_that);case _ReportsLoading() when reportsLoading != null:
return reportsLoading(_that);case _ReportsLoaded() when reportsLoaded != null:
return reportsLoaded(_that);case _ReportsFailure() when reportsFailure != null:
return reportsFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ReportsInitial value)  reportsInitial,required TResult Function( _ReportsLoading value)  reportsLoading,required TResult Function( _ReportsLoaded value)  reportsLoaded,required TResult Function( _ReportsFailure value)  reportsFailure,}){
final _that = this;
switch (_that) {
case _ReportsInitial():
return reportsInitial(_that);case _ReportsLoading():
return reportsLoading(_that);case _ReportsLoaded():
return reportsLoaded(_that);case _ReportsFailure():
return reportsFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ReportsInitial value)?  reportsInitial,TResult? Function( _ReportsLoading value)?  reportsLoading,TResult? Function( _ReportsLoaded value)?  reportsLoaded,TResult? Function( _ReportsFailure value)?  reportsFailure,}){
final _that = this;
switch (_that) {
case _ReportsInitial() when reportsInitial != null:
return reportsInitial(_that);case _ReportsLoading() when reportsLoading != null:
return reportsLoading(_that);case _ReportsLoaded() when reportsLoaded != null:
return reportsLoaded(_that);case _ReportsFailure() when reportsFailure != null:
return reportsFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  reportsInitial,TResult Function()?  reportsLoading,TResult Function( DashboardStats stats,  List<OutOfStockProduct> outOfStockProducts,  bool isLoadingOos,  String? oosFailure)?  reportsLoaded,TResult Function( String message)?  reportsFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsInitial() when reportsInitial != null:
return reportsInitial();case _ReportsLoading() when reportsLoading != null:
return reportsLoading();case _ReportsLoaded() when reportsLoaded != null:
return reportsLoaded(_that.stats,_that.outOfStockProducts,_that.isLoadingOos,_that.oosFailure);case _ReportsFailure() when reportsFailure != null:
return reportsFailure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  reportsInitial,required TResult Function()  reportsLoading,required TResult Function( DashboardStats stats,  List<OutOfStockProduct> outOfStockProducts,  bool isLoadingOos,  String? oosFailure)  reportsLoaded,required TResult Function( String message)  reportsFailure,}) {final _that = this;
switch (_that) {
case _ReportsInitial():
return reportsInitial();case _ReportsLoading():
return reportsLoading();case _ReportsLoaded():
return reportsLoaded(_that.stats,_that.outOfStockProducts,_that.isLoadingOos,_that.oosFailure);case _ReportsFailure():
return reportsFailure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  reportsInitial,TResult? Function()?  reportsLoading,TResult? Function( DashboardStats stats,  List<OutOfStockProduct> outOfStockProducts,  bool isLoadingOos,  String? oosFailure)?  reportsLoaded,TResult? Function( String message)?  reportsFailure,}) {final _that = this;
switch (_that) {
case _ReportsInitial() when reportsInitial != null:
return reportsInitial();case _ReportsLoading() when reportsLoading != null:
return reportsLoading();case _ReportsLoaded() when reportsLoaded != null:
return reportsLoaded(_that.stats,_that.outOfStockProducts,_that.isLoadingOos,_that.oosFailure);case _ReportsFailure() when reportsFailure != null:
return reportsFailure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsInitial implements ReportsState {
  const _ReportsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.reportsInitial()';
}


}




/// @nodoc


class _ReportsLoading implements ReportsState {
  const _ReportsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.reportsLoading()';
}


}




/// @nodoc


class _ReportsLoaded implements ReportsState {
  const _ReportsLoaded({required this.stats, required final  List<OutOfStockProduct> outOfStockProducts, required this.isLoadingOos, this.oosFailure}): _outOfStockProducts = outOfStockProducts;
  

 final  DashboardStats stats;
 final  List<OutOfStockProduct> _outOfStockProducts;
 List<OutOfStockProduct> get outOfStockProducts {
  if (_outOfStockProducts is EqualUnmodifiableListView) return _outOfStockProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outOfStockProducts);
}

 final  bool isLoadingOos;
 final  String? oosFailure;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsLoadedCopyWith<_ReportsLoaded> get copyWith => __$ReportsLoadedCopyWithImpl<_ReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsLoaded&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._outOfStockProducts, _outOfStockProducts)&&(identical(other.isLoadingOos, isLoadingOos) || other.isLoadingOos == isLoadingOos)&&(identical(other.oosFailure, oosFailure) || other.oosFailure == oosFailure));
}


@override
int get hashCode => Object.hash(runtimeType,stats,const DeepCollectionEquality().hash(_outOfStockProducts),isLoadingOos,oosFailure);

@override
String toString() {
  return 'ReportsState.reportsLoaded(stats: $stats, outOfStockProducts: $outOfStockProducts, isLoadingOos: $isLoadingOos, oosFailure: $oosFailure)';
}


}

/// @nodoc
abstract mixin class _$ReportsLoadedCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsLoadedCopyWith(_ReportsLoaded value, $Res Function(_ReportsLoaded) _then) = __$ReportsLoadedCopyWithImpl;
@useResult
$Res call({
 DashboardStats stats, List<OutOfStockProduct> outOfStockProducts, bool isLoadingOos, String? oosFailure
});




}
/// @nodoc
class __$ReportsLoadedCopyWithImpl<$Res>
    implements _$ReportsLoadedCopyWith<$Res> {
  __$ReportsLoadedCopyWithImpl(this._self, this._then);

  final _ReportsLoaded _self;
  final $Res Function(_ReportsLoaded) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? outOfStockProducts = null,Object? isLoadingOos = null,Object? oosFailure = freezed,}) {
  return _then(_ReportsLoaded(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DashboardStats,outOfStockProducts: null == outOfStockProducts ? _self._outOfStockProducts : outOfStockProducts // ignore: cast_nullable_to_non_nullable
as List<OutOfStockProduct>,isLoadingOos: null == isLoadingOos ? _self.isLoadingOos : isLoadingOos // ignore: cast_nullable_to_non_nullable
as bool,oosFailure: freezed == oosFailure ? _self.oosFailure : oosFailure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ReportsFailure implements ReportsState {
  const _ReportsFailure(this.message);
  

 final  String message;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsFailureCopyWith<_ReportsFailure> get copyWith => __$ReportsFailureCopyWithImpl<_ReportsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ReportsState.reportsFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReportsFailureCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsFailureCopyWith(_ReportsFailure value, $Res Function(_ReportsFailure) _then) = __$ReportsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ReportsFailureCopyWithImpl<$Res>
    implements _$ReportsFailureCopyWith<$Res> {
  __$ReportsFailureCopyWithImpl(this._self, this._then);

  final _ReportsFailure _self;
  final $Res Function(_ReportsFailure) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ReportsFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
