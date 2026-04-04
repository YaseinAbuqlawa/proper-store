// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 ProductsStatus get status; List<ProductModel> get products; bool get hasMore; DocumentSnapshot? get lastDoc; ServerFailure? get failure; String get searchQuery;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(products),hasMore,lastDoc,failure,searchQuery);

@override
String toString() {
  return 'ProductsState(status: $status, products: $products, hasMore: $hasMore, lastDoc: $lastDoc, failure: $failure, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 ProductsStatus status, List<ProductModel> products, bool hasMore, DocumentSnapshot? lastDoc, ServerFailure? failure, String searchQuery
});




}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? products = null,Object? hasMore = null,Object? lastDoc = freezed,Object? failure = freezed,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductsStatus,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,lastDoc: freezed == lastDoc ? _self.lastDoc : lastDoc // ignore: cast_nullable_to_non_nullable
as DocumentSnapshot?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProductsStatus status,  List<ProductModel> products,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.status,_that.products,_that.hasMore,_that.lastDoc,_that.failure,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProductsStatus status,  List<ProductModel> products,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.status,_that.products,_that.hasMore,_that.lastDoc,_that.failure,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProductsStatus status,  List<ProductModel> products,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.status,_that.products,_that.hasMore,_that.lastDoc,_that.failure,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState extends ProductsState {
  const _ProductsState({this.status = ProductsStatus.initial, final  List<ProductModel> products = const [], this.hasMore = true, this.lastDoc, this.failure, this.searchQuery = ''}): _products = products,super._();
  

@override@JsonKey() final  ProductsStatus status;
 final  List<ProductModel> _products;
@override@JsonKey() List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  bool hasMore;
@override final  DocumentSnapshot? lastDoc;
@override final  ServerFailure? failure;
@override@JsonKey() final  String searchQuery;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_products),hasMore,lastDoc,failure,searchQuery);

@override
String toString() {
  return 'ProductsState(status: $status, products: $products, hasMore: $hasMore, lastDoc: $lastDoc, failure: $failure, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 ProductsStatus status, List<ProductModel> products, bool hasMore, DocumentSnapshot? lastDoc, ServerFailure? failure, String searchQuery
});




}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? products = null,Object? hasMore = null,Object? lastDoc = freezed,Object? failure = freezed,Object? searchQuery = null,}) {
  return _then(_ProductsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductsStatus,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,lastDoc: freezed == lastDoc ? _self.lastDoc : lastDoc // ignore: cast_nullable_to_non_nullable
as DocumentSnapshot?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
