// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsScreenState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsScreenState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsScreenState()';
}


}

/// @nodoc
class $ProductsScreenStateCopyWith<$Res>  {
$ProductsScreenStateCopyWith(ProductsScreenState _, $Res Function(ProductsScreenState) __);
}


/// Adds pattern-matching-related methods to [ProductsScreenState].
extension ProductsScreenStatePatterns on ProductsScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Paginated value)?  paginated,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Paginated() when paginated != null:
return paginated(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Paginated value)  paginated,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Paginated():
return paginated(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Paginated value)?  paginated,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Paginated() when paginated != null:
return paginated(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductModel> products,  bool hasMore,  bool isLoadingMore)?  paginated,TResult Function( String failureMessage)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Paginated() when paginated != null:
return paginated(_that.products,_that.hasMore,_that.isLoadingMore);case _Failure() when failure != null:
return failure(_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductModel> products,  bool hasMore,  bool isLoadingMore)  paginated,required TResult Function( String failureMessage)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Paginated():
return paginated(_that.products,_that.hasMore,_that.isLoadingMore);case _Failure():
return failure(_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductModel> products,  bool hasMore,  bool isLoadingMore)?  paginated,TResult? Function( String failureMessage)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Paginated() when paginated != null:
return paginated(_that.products,_that.hasMore,_that.isLoadingMore);case _Failure() when failure != null:
return failure(_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductsScreenState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsScreenState.initial()';
}


}




/// @nodoc


class _Loading implements ProductsScreenState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsScreenState.loading()';
}


}




/// @nodoc


class _Paginated implements ProductsScreenState {
  const _Paginated({required final  List<ProductModel> products, required this.hasMore, required this.isLoadingMore}): _products = products;
  

 final  List<ProductModel> _products;
 List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  bool hasMore;
 final  bool isLoadingMore;

/// Create a copy of ProductsScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedCopyWith<_Paginated> get copyWith => __$PaginatedCopyWithImpl<_Paginated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paginated&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),hasMore,isLoadingMore);

@override
String toString() {
  return 'ProductsScreenState.paginated(products: $products, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$PaginatedCopyWith<$Res> implements $ProductsScreenStateCopyWith<$Res> {
  factory _$PaginatedCopyWith(_Paginated value, $Res Function(_Paginated) _then) = __$PaginatedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products, bool hasMore, bool isLoadingMore
});




}
/// @nodoc
class __$PaginatedCopyWithImpl<$Res>
    implements _$PaginatedCopyWith<$Res> {
  __$PaginatedCopyWithImpl(this._self, this._then);

  final _Paginated _self;
  final $Res Function(_Paginated) _then;

/// Create a copy of ProductsScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? hasMore = null,Object? isLoadingMore = null,}) {
  return _then(_Paginated(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Failure implements ProductsScreenState {
  const _Failure({required this.failureMessage});
  

 final  String failureMessage;

/// Create a copy of ProductsScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,failureMessage);

@override
String toString() {
  return 'ProductsScreenState.failure(failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $ProductsScreenStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String failureMessage
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of ProductsScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failureMessage = null,}) {
  return _then(_Failure(
failureMessage: null == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
