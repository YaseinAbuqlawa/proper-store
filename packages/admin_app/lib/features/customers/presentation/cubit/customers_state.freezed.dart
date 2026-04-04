// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomersState {

 CustomersStatus get status; List<CustomerModel> get allCustomers; List<CustomerModel> get filteredCustomers; ServerFailure? get failure;
/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomersStateCopyWith<CustomersState> get copyWith => _$CustomersStateCopyWithImpl<CustomersState>(this as CustomersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomersState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allCustomers, allCustomers)&&const DeepCollectionEquality().equals(other.filteredCustomers, filteredCustomers)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(allCustomers),const DeepCollectionEquality().hash(filteredCustomers),failure);

@override
String toString() {
  return 'CustomersState(status: $status, allCustomers: $allCustomers, filteredCustomers: $filteredCustomers, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CustomersStateCopyWith<$Res>  {
  factory $CustomersStateCopyWith(CustomersState value, $Res Function(CustomersState) _then) = _$CustomersStateCopyWithImpl;
@useResult
$Res call({
 CustomersStatus status, List<CustomerModel> allCustomers, List<CustomerModel> filteredCustomers, ServerFailure? failure
});




}
/// @nodoc
class _$CustomersStateCopyWithImpl<$Res>
    implements $CustomersStateCopyWith<$Res> {
  _$CustomersStateCopyWithImpl(this._self, this._then);

  final CustomersState _self;
  final $Res Function(CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? allCustomers = null,Object? filteredCustomers = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomersStatus,allCustomers: null == allCustomers ? _self.allCustomers : allCustomers // ignore: cast_nullable_to_non_nullable
as List<CustomerModel>,filteredCustomers: null == filteredCustomers ? _self.filteredCustomers : filteredCustomers // ignore: cast_nullable_to_non_nullable
as List<CustomerModel>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomersState].
extension CustomersStatePatterns on CustomersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomersState value)  $default,){
final _that = this;
switch (_that) {
case _CustomersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomersState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CustomersStatus status,  List<CustomerModel> allCustomers,  List<CustomerModel> filteredCustomers,  ServerFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.status,_that.allCustomers,_that.filteredCustomers,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CustomersStatus status,  List<CustomerModel> allCustomers,  List<CustomerModel> filteredCustomers,  ServerFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _CustomersState():
return $default(_that.status,_that.allCustomers,_that.filteredCustomers,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CustomersStatus status,  List<CustomerModel> allCustomers,  List<CustomerModel> filteredCustomers,  ServerFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.status,_that.allCustomers,_that.filteredCustomers,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CustomersState implements CustomersState {
  const _CustomersState({this.status = CustomersStatus.initial, final  List<CustomerModel> allCustomers = const [], final  List<CustomerModel> filteredCustomers = const [], this.failure}): _allCustomers = allCustomers,_filteredCustomers = filteredCustomers;
  

@override@JsonKey() final  CustomersStatus status;
 final  List<CustomerModel> _allCustomers;
@override@JsonKey() List<CustomerModel> get allCustomers {
  if (_allCustomers is EqualUnmodifiableListView) return _allCustomers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allCustomers);
}

 final  List<CustomerModel> _filteredCustomers;
@override@JsonKey() List<CustomerModel> get filteredCustomers {
  if (_filteredCustomers is EqualUnmodifiableListView) return _filteredCustomers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCustomers);
}

@override final  ServerFailure? failure;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomersStateCopyWith<_CustomersState> get copyWith => __$CustomersStateCopyWithImpl<_CustomersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomersState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allCustomers, _allCustomers)&&const DeepCollectionEquality().equals(other._filteredCustomers, _filteredCustomers)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_allCustomers),const DeepCollectionEquality().hash(_filteredCustomers),failure);

@override
String toString() {
  return 'CustomersState(status: $status, allCustomers: $allCustomers, filteredCustomers: $filteredCustomers, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CustomersStateCopyWith<$Res> implements $CustomersStateCopyWith<$Res> {
  factory _$CustomersStateCopyWith(_CustomersState value, $Res Function(_CustomersState) _then) = __$CustomersStateCopyWithImpl;
@override @useResult
$Res call({
 CustomersStatus status, List<CustomerModel> allCustomers, List<CustomerModel> filteredCustomers, ServerFailure? failure
});




}
/// @nodoc
class __$CustomersStateCopyWithImpl<$Res>
    implements _$CustomersStateCopyWith<$Res> {
  __$CustomersStateCopyWithImpl(this._self, this._then);

  final _CustomersState _self;
  final $Res Function(_CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? allCustomers = null,Object? filteredCustomers = null,Object? failure = freezed,}) {
  return _then(_CustomersState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomersStatus,allCustomers: null == allCustomers ? _self._allCustomers : allCustomers // ignore: cast_nullable_to_non_nullable
as List<CustomerModel>,filteredCustomers: null == filteredCustomers ? _self._filteredCustomers : filteredCustomers // ignore: cast_nullable_to_non_nullable
as List<CustomerModel>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ServerFailure?,
  ));
}


}

// dart format on
