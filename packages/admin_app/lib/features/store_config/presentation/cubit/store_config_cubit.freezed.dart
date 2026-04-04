// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_config_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoreConfigState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreConfigState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoreConfigState()';
}


}

/// @nodoc
class $StoreConfigStateCopyWith<$Res>  {
$StoreConfigStateCopyWith(StoreConfigState _, $Res Function(StoreConfigState) __);
}


/// Adds pattern-matching-related methods to [StoreConfigState].
extension StoreConfigStatePatterns on StoreConfigState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( StoreConfigLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case StoreConfigLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( StoreConfigLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case StoreConfigLoaded():
return loaded(_that);case _Failure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( StoreConfigLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case StoreConfigLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<String, double> shippingCosts,  List<CategoryModel> categories,  HomeCollectionBannerModel? banner,  bool isSavingShipping,  bool isSavingCategory,  bool isSavingBanner)?  loaded,TResult Function( ServerFailure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case StoreConfigLoaded() when loaded != null:
return loaded(_that.shippingCosts,_that.categories,_that.banner,_that.isSavingShipping,_that.isSavingCategory,_that.isSavingBanner);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<String, double> shippingCosts,  List<CategoryModel> categories,  HomeCollectionBannerModel? banner,  bool isSavingShipping,  bool isSavingCategory,  bool isSavingBanner)  loaded,required TResult Function( ServerFailure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case StoreConfigLoaded():
return loaded(_that.shippingCosts,_that.categories,_that.banner,_that.isSavingShipping,_that.isSavingCategory,_that.isSavingBanner);case _Failure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<String, double> shippingCosts,  List<CategoryModel> categories,  HomeCollectionBannerModel? banner,  bool isSavingShipping,  bool isSavingCategory,  bool isSavingBanner)?  loaded,TResult? Function( ServerFailure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case StoreConfigLoaded() when loaded != null:
return loaded(_that.shippingCosts,_that.categories,_that.banner,_that.isSavingShipping,_that.isSavingCategory,_that.isSavingBanner);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements StoreConfigState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoreConfigState.initial()';
}


}




/// @nodoc


class _Loading implements StoreConfigState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoreConfigState.loading()';
}


}




/// @nodoc


class StoreConfigLoaded implements StoreConfigState {
  const StoreConfigLoaded({required final  Map<String, double> shippingCosts, required final  List<CategoryModel> categories, required this.banner, this.isSavingShipping = false, this.isSavingCategory = false, this.isSavingBanner = false}): _shippingCosts = shippingCosts,_categories = categories;
  

 final  Map<String, double> _shippingCosts;
 Map<String, double> get shippingCosts {
  if (_shippingCosts is EqualUnmodifiableMapView) return _shippingCosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_shippingCosts);
}

 final  List<CategoryModel> _categories;
 List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  HomeCollectionBannerModel? banner;
@JsonKey() final  bool isSavingShipping;
@JsonKey() final  bool isSavingCategory;
@JsonKey() final  bool isSavingBanner;

/// Create a copy of StoreConfigState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreConfigLoadedCopyWith<StoreConfigLoaded> get copyWith => _$StoreConfigLoadedCopyWithImpl<StoreConfigLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreConfigLoaded&&const DeepCollectionEquality().equals(other._shippingCosts, _shippingCosts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.isSavingShipping, isSavingShipping) || other.isSavingShipping == isSavingShipping)&&(identical(other.isSavingCategory, isSavingCategory) || other.isSavingCategory == isSavingCategory)&&(identical(other.isSavingBanner, isSavingBanner) || other.isSavingBanner == isSavingBanner));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shippingCosts),const DeepCollectionEquality().hash(_categories),banner,isSavingShipping,isSavingCategory,isSavingBanner);

@override
String toString() {
  return 'StoreConfigState.loaded(shippingCosts: $shippingCosts, categories: $categories, banner: $banner, isSavingShipping: $isSavingShipping, isSavingCategory: $isSavingCategory, isSavingBanner: $isSavingBanner)';
}


}

/// @nodoc
abstract mixin class $StoreConfigLoadedCopyWith<$Res> implements $StoreConfigStateCopyWith<$Res> {
  factory $StoreConfigLoadedCopyWith(StoreConfigLoaded value, $Res Function(StoreConfigLoaded) _then) = _$StoreConfigLoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, double> shippingCosts, List<CategoryModel> categories, HomeCollectionBannerModel? banner, bool isSavingShipping, bool isSavingCategory, bool isSavingBanner
});


$HomeCollectionBannerModelCopyWith<$Res>? get banner;

}
/// @nodoc
class _$StoreConfigLoadedCopyWithImpl<$Res>
    implements $StoreConfigLoadedCopyWith<$Res> {
  _$StoreConfigLoadedCopyWithImpl(this._self, this._then);

  final StoreConfigLoaded _self;
  final $Res Function(StoreConfigLoaded) _then;

/// Create a copy of StoreConfigState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shippingCosts = null,Object? categories = null,Object? banner = freezed,Object? isSavingShipping = null,Object? isSavingCategory = null,Object? isSavingBanner = null,}) {
  return _then(StoreConfigLoaded(
shippingCosts: null == shippingCosts ? _self._shippingCosts : shippingCosts // ignore: cast_nullable_to_non_nullable
as Map<String, double>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as HomeCollectionBannerModel?,isSavingShipping: null == isSavingShipping ? _self.isSavingShipping : isSavingShipping // ignore: cast_nullable_to_non_nullable
as bool,isSavingCategory: null == isSavingCategory ? _self.isSavingCategory : isSavingCategory // ignore: cast_nullable_to_non_nullable
as bool,isSavingBanner: null == isSavingBanner ? _self.isSavingBanner : isSavingBanner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of StoreConfigState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeCollectionBannerModelCopyWith<$Res>? get banner {
    if (_self.banner == null) {
    return null;
  }

  return $HomeCollectionBannerModelCopyWith<$Res>(_self.banner!, (value) {
    return _then(_self.copyWith(banner: value));
  });
}
}

/// @nodoc


class _Failure implements StoreConfigState {
  const _Failure(this.failure);
  

 final  ServerFailure failure;

/// Create a copy of StoreConfigState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'StoreConfigState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $StoreConfigStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 ServerFailure failure
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of StoreConfigState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure,
  ));
}


}

// dart format on
