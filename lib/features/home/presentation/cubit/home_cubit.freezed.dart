// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 HomeStates get bannerState; HomeStates get productsState; String get failureCode; HomeCollectionBannerModel? get homeCollectionBannerModel; List<ProductModel> get mostSoldProductsList;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.bannerState, bannerState) || other.bannerState == bannerState)&&(identical(other.productsState, productsState) || other.productsState == productsState)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.homeCollectionBannerModel, homeCollectionBannerModel) || other.homeCollectionBannerModel == homeCollectionBannerModel)&&const DeepCollectionEquality().equals(other.mostSoldProductsList, mostSoldProductsList));
}


@override
int get hashCode => Object.hash(runtimeType,bannerState,productsState,failureCode,homeCollectionBannerModel,const DeepCollectionEquality().hash(mostSoldProductsList));

@override
String toString() {
  return 'HomeState(bannerState: $bannerState, productsState: $productsState, failureCode: $failureCode, homeCollectionBannerModel: $homeCollectionBannerModel, mostSoldProductsList: $mostSoldProductsList)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 HomeStates bannerState, HomeStates productsState, String failureCode, HomeCollectionBannerModel? homeCollectionBannerModel, List<ProductModel> mostSoldProductsList
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bannerState = null,Object? productsState = null,Object? failureCode = null,Object? homeCollectionBannerModel = freezed,Object? mostSoldProductsList = null,}) {
  return _then(_self.copyWith(
bannerState: null == bannerState ? _self.bannerState : bannerState // ignore: cast_nullable_to_non_nullable
as HomeStates,productsState: null == productsState ? _self.productsState : productsState // ignore: cast_nullable_to_non_nullable
as HomeStates,failureCode: null == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String,homeCollectionBannerModel: freezed == homeCollectionBannerModel ? _self.homeCollectionBannerModel : homeCollectionBannerModel // ignore: cast_nullable_to_non_nullable
as HomeCollectionBannerModel?,mostSoldProductsList: null == mostSoldProductsList ? _self.mostSoldProductsList : mostSoldProductsList // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeStates bannerState,  HomeStates productsState,  String failureCode,  HomeCollectionBannerModel? homeCollectionBannerModel,  List<ProductModel> mostSoldProductsList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannerState,_that.productsState,_that.failureCode,_that.homeCollectionBannerModel,_that.mostSoldProductsList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeStates bannerState,  HomeStates productsState,  String failureCode,  HomeCollectionBannerModel? homeCollectionBannerModel,  List<ProductModel> mostSoldProductsList)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.bannerState,_that.productsState,_that.failureCode,_that.homeCollectionBannerModel,_that.mostSoldProductsList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeStates bannerState,  HomeStates productsState,  String failureCode,  HomeCollectionBannerModel? homeCollectionBannerModel,  List<ProductModel> mostSoldProductsList)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannerState,_that.productsState,_that.failureCode,_that.homeCollectionBannerModel,_that.mostSoldProductsList);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.bannerState = HomeStates.initial, this.productsState = HomeStates.initial, this.failureCode = '', this.homeCollectionBannerModel, final  List<ProductModel> mostSoldProductsList = const []}): _mostSoldProductsList = mostSoldProductsList;
  

@override@JsonKey() final  HomeStates bannerState;
@override@JsonKey() final  HomeStates productsState;
@override@JsonKey() final  String failureCode;
@override final  HomeCollectionBannerModel? homeCollectionBannerModel;
 final  List<ProductModel> _mostSoldProductsList;
@override@JsonKey() List<ProductModel> get mostSoldProductsList {
  if (_mostSoldProductsList is EqualUnmodifiableListView) return _mostSoldProductsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mostSoldProductsList);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.bannerState, bannerState) || other.bannerState == bannerState)&&(identical(other.productsState, productsState) || other.productsState == productsState)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.homeCollectionBannerModel, homeCollectionBannerModel) || other.homeCollectionBannerModel == homeCollectionBannerModel)&&const DeepCollectionEquality().equals(other._mostSoldProductsList, _mostSoldProductsList));
}


@override
int get hashCode => Object.hash(runtimeType,bannerState,productsState,failureCode,homeCollectionBannerModel,const DeepCollectionEquality().hash(_mostSoldProductsList));

@override
String toString() {
  return 'HomeState(bannerState: $bannerState, productsState: $productsState, failureCode: $failureCode, homeCollectionBannerModel: $homeCollectionBannerModel, mostSoldProductsList: $mostSoldProductsList)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 HomeStates bannerState, HomeStates productsState, String failureCode, HomeCollectionBannerModel? homeCollectionBannerModel, List<ProductModel> mostSoldProductsList
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bannerState = null,Object? productsState = null,Object? failureCode = null,Object? homeCollectionBannerModel = freezed,Object? mostSoldProductsList = null,}) {
  return _then(_HomeState(
bannerState: null == bannerState ? _self.bannerState : bannerState // ignore: cast_nullable_to_non_nullable
as HomeStates,productsState: null == productsState ? _self.productsState : productsState // ignore: cast_nullable_to_non_nullable
as HomeStates,failureCode: null == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String,homeCollectionBannerModel: freezed == homeCollectionBannerModel ? _self.homeCollectionBannerModel : homeCollectionBannerModel // ignore: cast_nullable_to_non_nullable
as HomeCollectionBannerModel?,mostSoldProductsList: null == mostSoldProductsList ? _self._mostSoldProductsList : mostSoldProductsList // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,
  ));
}


}

// dart format on
