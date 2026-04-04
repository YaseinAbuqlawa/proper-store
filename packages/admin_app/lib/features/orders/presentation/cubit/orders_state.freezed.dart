// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrdersState {

 OrdersStatus get status; List<OrderModel> get orders; bool get hasMore; DocumentSnapshot? get lastDoc; ServerFailure? get failure; OrderStatus? get activeFilter; String? get customerIdFilter;
/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersStateCopyWith<OrdersState> get copyWith => _$OrdersStateCopyWithImpl<OrdersState>(this as OrdersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.orders, orders)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.customerIdFilter, customerIdFilter) || other.customerIdFilter == customerIdFilter));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(orders),hasMore,lastDoc,failure,activeFilter,customerIdFilter);

@override
String toString() {
  return 'OrdersState(status: $status, orders: $orders, hasMore: $hasMore, lastDoc: $lastDoc, failure: $failure, activeFilter: $activeFilter, customerIdFilter: $customerIdFilter)';
}


}

/// @nodoc
abstract mixin class $OrdersStateCopyWith<$Res>  {
  factory $OrdersStateCopyWith(OrdersState value, $Res Function(OrdersState) _then) = _$OrdersStateCopyWithImpl;
@useResult
$Res call({
 OrdersStatus status, List<OrderModel> orders, bool hasMore, DocumentSnapshot? lastDoc, ServerFailure? failure, OrderStatus? activeFilter, String? customerIdFilter
});




}
/// @nodoc
class _$OrdersStateCopyWithImpl<$Res>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._self, this._then);

  final OrdersState _self;
  final $Res Function(OrdersState) _then;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? orders = null,Object? hasMore = null,Object? lastDoc = freezed,Object? failure = freezed,Object? activeFilter = freezed,Object? customerIdFilter = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrdersStatus,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,lastDoc: freezed == lastDoc ? _self.lastDoc : lastDoc // ignore: cast_nullable_to_non_nullable
as DocumentSnapshot?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as OrderStatus?,customerIdFilter: freezed == customerIdFilter ? _self.customerIdFilter : customerIdFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrdersState].
extension OrdersStatePatterns on OrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrdersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrdersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrdersState value)  $default,){
final _that = this;
switch (_that) {
case _OrdersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrdersState value)?  $default,){
final _that = this;
switch (_that) {
case _OrdersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrdersStatus status,  List<OrderModel> orders,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  OrderStatus? activeFilter,  String? customerIdFilter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrdersState() when $default != null:
return $default(_that.status,_that.orders,_that.hasMore,_that.lastDoc,_that.failure,_that.activeFilter,_that.customerIdFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrdersStatus status,  List<OrderModel> orders,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  OrderStatus? activeFilter,  String? customerIdFilter)  $default,) {final _that = this;
switch (_that) {
case _OrdersState():
return $default(_that.status,_that.orders,_that.hasMore,_that.lastDoc,_that.failure,_that.activeFilter,_that.customerIdFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrdersStatus status,  List<OrderModel> orders,  bool hasMore,  DocumentSnapshot? lastDoc,  ServerFailure? failure,  OrderStatus? activeFilter,  String? customerIdFilter)?  $default,) {final _that = this;
switch (_that) {
case _OrdersState() when $default != null:
return $default(_that.status,_that.orders,_that.hasMore,_that.lastDoc,_that.failure,_that.activeFilter,_that.customerIdFilter);case _:
  return null;

}
}

}

/// @nodoc


class _OrdersState implements OrdersState {
  const _OrdersState({this.status = OrdersStatus.initial, final  List<OrderModel> orders = const [], this.hasMore = true, this.lastDoc, this.failure, this.activeFilter = null, this.customerIdFilter = null}): _orders = orders;
  

@override@JsonKey() final  OrdersStatus status;
 final  List<OrderModel> _orders;
@override@JsonKey() List<OrderModel> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

@override@JsonKey() final  bool hasMore;
@override final  DocumentSnapshot? lastDoc;
@override final  ServerFailure? failure;
@override@JsonKey() final  OrderStatus? activeFilter;
@override@JsonKey() final  String? customerIdFilter;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrdersStateCopyWith<_OrdersState> get copyWith => __$OrdersStateCopyWithImpl<_OrdersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrdersState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.customerIdFilter, customerIdFilter) || other.customerIdFilter == customerIdFilter));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_orders),hasMore,lastDoc,failure,activeFilter,customerIdFilter);

@override
String toString() {
  return 'OrdersState(status: $status, orders: $orders, hasMore: $hasMore, lastDoc: $lastDoc, failure: $failure, activeFilter: $activeFilter, customerIdFilter: $customerIdFilter)';
}


}

/// @nodoc
abstract mixin class _$OrdersStateCopyWith<$Res> implements $OrdersStateCopyWith<$Res> {
  factory _$OrdersStateCopyWith(_OrdersState value, $Res Function(_OrdersState) _then) = __$OrdersStateCopyWithImpl;
@override @useResult
$Res call({
 OrdersStatus status, List<OrderModel> orders, bool hasMore, DocumentSnapshot? lastDoc, ServerFailure? failure, OrderStatus? activeFilter, String? customerIdFilter
});




}
/// @nodoc
class __$OrdersStateCopyWithImpl<$Res>
    implements _$OrdersStateCopyWith<$Res> {
  __$OrdersStateCopyWithImpl(this._self, this._then);

  final _OrdersState _self;
  final $Res Function(_OrdersState) _then;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? orders = null,Object? hasMore = null,Object? lastDoc = freezed,Object? failure = freezed,Object? activeFilter = freezed,Object? customerIdFilter = freezed,}) {
  return _then(_OrdersState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrdersStatus,orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,lastDoc: freezed == lastDoc ? _self.lastDoc : lastDoc // ignore: cast_nullable_to_non_nullable
as DocumentSnapshot?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as OrderStatus?,customerIdFilter: freezed == customerIdFilter ? _self.customerIdFilter : customerIdFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
