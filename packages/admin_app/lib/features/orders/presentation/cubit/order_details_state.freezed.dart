// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailsState {

 OrderModel? get order; CustomerModel? get customer; bool get isLoadingCustomer; bool get isUpdatingStatus; ServerFailure? get failure;
/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsStateCopyWith<OrderDetailsState> get copyWith => _$OrderDetailsStateCopyWithImpl<OrderDetailsState>(this as OrderDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsState&&(identical(other.order, order) || other.order == order)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.isLoadingCustomer, isLoadingCustomer) || other.isLoadingCustomer == isLoadingCustomer)&&(identical(other.isUpdatingStatus, isUpdatingStatus) || other.isUpdatingStatus == isUpdatingStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,order,customer,isLoadingCustomer,isUpdatingStatus,failure);

@override
String toString() {
  return 'OrderDetailsState(order: $order, customer: $customer, isLoadingCustomer: $isLoadingCustomer, isUpdatingStatus: $isUpdatingStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsStateCopyWith<$Res>  {
  factory $OrderDetailsStateCopyWith(OrderDetailsState value, $Res Function(OrderDetailsState) _then) = _$OrderDetailsStateCopyWithImpl;
@useResult
$Res call({
 OrderModel? order, CustomerModel? customer, bool isLoadingCustomer, bool isUpdatingStatus, ServerFailure? failure
});


$OrderModelCopyWith<$Res>? get order;$CustomerModelCopyWith<$Res>? get customer;

}
/// @nodoc
class _$OrderDetailsStateCopyWithImpl<$Res>
    implements $OrderDetailsStateCopyWith<$Res> {
  _$OrderDetailsStateCopyWithImpl(this._self, this._then);

  final OrderDetailsState _self;
  final $Res Function(OrderDetailsState) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = freezed,Object? customer = freezed,Object? isLoadingCustomer = null,Object? isUpdatingStatus = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerModel?,isLoadingCustomer: null == isLoadingCustomer ? _self.isLoadingCustomer : isLoadingCustomer // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingStatus: null == isUpdatingStatus ? _self.isUpdatingStatus : isUpdatingStatus // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,
  ));
}
/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderModelCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $OrderModelCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderDetailsState].
extension OrderDetailsStatePatterns on OrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _OrderDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrderModel? order,  CustomerModel? customer,  bool isLoadingCustomer,  bool isUpdatingStatus,  ServerFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
return $default(_that.order,_that.customer,_that.isLoadingCustomer,_that.isUpdatingStatus,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrderModel? order,  CustomerModel? customer,  bool isLoadingCustomer,  bool isUpdatingStatus,  ServerFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _OrderDetailsState():
return $default(_that.order,_that.customer,_that.isLoadingCustomer,_that.isUpdatingStatus,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrderModel? order,  CustomerModel? customer,  bool isLoadingCustomer,  bool isUpdatingStatus,  ServerFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
return $default(_that.order,_that.customer,_that.isLoadingCustomer,_that.isUpdatingStatus,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _OrderDetailsState implements OrderDetailsState {
  const _OrderDetailsState({this.order, this.customer, this.isLoadingCustomer = false, this.isUpdatingStatus = false, this.failure});
  

@override final  OrderModel? order;
@override final  CustomerModel? customer;
@override@JsonKey() final  bool isLoadingCustomer;
@override@JsonKey() final  bool isUpdatingStatus;
@override final  ServerFailure? failure;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailsStateCopyWith<_OrderDetailsState> get copyWith => __$OrderDetailsStateCopyWithImpl<_OrderDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetailsState&&(identical(other.order, order) || other.order == order)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.isLoadingCustomer, isLoadingCustomer) || other.isLoadingCustomer == isLoadingCustomer)&&(identical(other.isUpdatingStatus, isUpdatingStatus) || other.isUpdatingStatus == isUpdatingStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,order,customer,isLoadingCustomer,isUpdatingStatus,failure);

@override
String toString() {
  return 'OrderDetailsState(order: $order, customer: $customer, isLoadingCustomer: $isLoadingCustomer, isUpdatingStatus: $isUpdatingStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailsStateCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory _$OrderDetailsStateCopyWith(_OrderDetailsState value, $Res Function(_OrderDetailsState) _then) = __$OrderDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 OrderModel? order, CustomerModel? customer, bool isLoadingCustomer, bool isUpdatingStatus, ServerFailure? failure
});


@override $OrderModelCopyWith<$Res>? get order;@override $CustomerModelCopyWith<$Res>? get customer;

}
/// @nodoc
class __$OrderDetailsStateCopyWithImpl<$Res>
    implements _$OrderDetailsStateCopyWith<$Res> {
  __$OrderDetailsStateCopyWithImpl(this._self, this._then);

  final _OrderDetailsState _self;
  final $Res Function(_OrderDetailsState) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = freezed,Object? customer = freezed,Object? isLoadingCustomer = null,Object? isUpdatingStatus = null,Object? failure = freezed,}) {
  return _then(_OrderDetailsState(
order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderModel?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerModel?,isLoadingCustomer: null == isLoadingCustomer ? _self.isLoadingCustomer : isLoadingCustomer // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingStatus: null == isUpdatingStatus ? _self.isUpdatingStatus : isUpdatingStatus // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,
  ));
}

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderModelCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $OrderModelCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerModelCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerModelCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}

// dart format on
