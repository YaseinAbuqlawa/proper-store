// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneAuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState()';
}


}

/// @nodoc
class $PhoneAuthStateCopyWith<$Res>  {
$PhoneAuthStateCopyWith(PhoneAuthState _, $Res Function(PhoneAuthState) __);
}


/// Adds pattern-matching-related methods to [PhoneAuthState].
extension PhoneAuthStatePatterns on PhoneAuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _PhoneLoading value)?  phoneLoading,TResult Function( _OtpLoading value)?  otpLoading,TResult Function( _OtpSent value)?  otpSent,TResult Function( _OtpIssue value)?  otpIssue,TResult Function( _OtpVerified value)?  otpVerified,TResult Function( _PhoneIssue value)?  phoneIssue,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _PhoneLoading() when phoneLoading != null:
return phoneLoading(_that);case _OtpLoading() when otpLoading != null:
return otpLoading(_that);case _OtpSent() when otpSent != null:
return otpSent(_that);case _OtpIssue() when otpIssue != null:
return otpIssue(_that);case _OtpVerified() when otpVerified != null:
return otpVerified(_that);case _PhoneIssue() when phoneIssue != null:
return phoneIssue(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _PhoneLoading value)  phoneLoading,required TResult Function( _OtpLoading value)  otpLoading,required TResult Function( _OtpSent value)  otpSent,required TResult Function( _OtpIssue value)  otpIssue,required TResult Function( _OtpVerified value)  otpVerified,required TResult Function( _PhoneIssue value)  phoneIssue,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _PhoneLoading():
return phoneLoading(_that);case _OtpLoading():
return otpLoading(_that);case _OtpSent():
return otpSent(_that);case _OtpIssue():
return otpIssue(_that);case _OtpVerified():
return otpVerified(_that);case _PhoneIssue():
return phoneIssue(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _PhoneLoading value)?  phoneLoading,TResult? Function( _OtpLoading value)?  otpLoading,TResult? Function( _OtpSent value)?  otpSent,TResult? Function( _OtpIssue value)?  otpIssue,TResult? Function( _OtpVerified value)?  otpVerified,TResult? Function( _PhoneIssue value)?  phoneIssue,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _PhoneLoading() when phoneLoading != null:
return phoneLoading(_that);case _OtpLoading() when otpLoading != null:
return otpLoading(_that);case _OtpSent() when otpSent != null:
return otpSent(_that);case _OtpIssue() when otpIssue != null:
return otpIssue(_that);case _OtpVerified() when otpVerified != null:
return otpVerified(_that);case _PhoneIssue() when phoneIssue != null:
return phoneIssue(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  phoneLoading,TResult Function()?  otpLoading,TResult Function()?  otpSent,TResult Function( String failureMessage)?  otpIssue,TResult Function()?  otpVerified,TResult Function( String failureMessage)?  phoneIssue,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _PhoneLoading() when phoneLoading != null:
return phoneLoading();case _OtpLoading() when otpLoading != null:
return otpLoading();case _OtpSent() when otpSent != null:
return otpSent();case _OtpIssue() when otpIssue != null:
return otpIssue(_that.failureMessage);case _OtpVerified() when otpVerified != null:
return otpVerified();case _PhoneIssue() when phoneIssue != null:
return phoneIssue(_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  phoneLoading,required TResult Function()  otpLoading,required TResult Function()  otpSent,required TResult Function( String failureMessage)  otpIssue,required TResult Function()  otpVerified,required TResult Function( String failureMessage)  phoneIssue,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _PhoneLoading():
return phoneLoading();case _OtpLoading():
return otpLoading();case _OtpSent():
return otpSent();case _OtpIssue():
return otpIssue(_that.failureMessage);case _OtpVerified():
return otpVerified();case _PhoneIssue():
return phoneIssue(_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  phoneLoading,TResult? Function()?  otpLoading,TResult? Function()?  otpSent,TResult? Function( String failureMessage)?  otpIssue,TResult? Function()?  otpVerified,TResult? Function( String failureMessage)?  phoneIssue,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _PhoneLoading() when phoneLoading != null:
return phoneLoading();case _OtpLoading() when otpLoading != null:
return otpLoading();case _OtpSent() when otpSent != null:
return otpSent();case _OtpIssue() when otpIssue != null:
return otpIssue(_that.failureMessage);case _OtpVerified() when otpVerified != null:
return otpVerified();case _PhoneIssue() when phoneIssue != null:
return phoneIssue(_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PhoneAuthState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState.initial()';
}


}




/// @nodoc


class _PhoneLoading implements PhoneAuthState {
  const _PhoneLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState.phoneLoading()';
}


}




/// @nodoc


class _OtpLoading implements PhoneAuthState {
  const _OtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState.otpLoading()';
}


}




/// @nodoc


class _OtpSent implements PhoneAuthState {
  const _OtpSent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpSent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState.otpSent()';
}


}




/// @nodoc


class _OtpIssue implements PhoneAuthState {
  const _OtpIssue({required this.failureMessage});
  

 final  String failureMessage;

/// Create a copy of PhoneAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpIssueCopyWith<_OtpIssue> get copyWith => __$OtpIssueCopyWithImpl<_OtpIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpIssue&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,failureMessage);

@override
String toString() {
  return 'PhoneAuthState.otpIssue(failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$OtpIssueCopyWith<$Res> implements $PhoneAuthStateCopyWith<$Res> {
  factory _$OtpIssueCopyWith(_OtpIssue value, $Res Function(_OtpIssue) _then) = __$OtpIssueCopyWithImpl;
@useResult
$Res call({
 String failureMessage
});




}
/// @nodoc
class __$OtpIssueCopyWithImpl<$Res>
    implements _$OtpIssueCopyWith<$Res> {
  __$OtpIssueCopyWithImpl(this._self, this._then);

  final _OtpIssue _self;
  final $Res Function(_OtpIssue) _then;

/// Create a copy of PhoneAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failureMessage = null,}) {
  return _then(_OtpIssue(
failureMessage: null == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OtpVerified implements PhoneAuthState {
  const _OtpVerified();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpVerified);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PhoneAuthState.otpVerified()';
}


}




/// @nodoc


class _PhoneIssue implements PhoneAuthState {
  const _PhoneIssue({required this.failureMessage});
  

 final  String failureMessage;

/// Create a copy of PhoneAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneIssueCopyWith<_PhoneIssue> get copyWith => __$PhoneIssueCopyWithImpl<_PhoneIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneIssue&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,failureMessage);

@override
String toString() {
  return 'PhoneAuthState.phoneIssue(failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$PhoneIssueCopyWith<$Res> implements $PhoneAuthStateCopyWith<$Res> {
  factory _$PhoneIssueCopyWith(_PhoneIssue value, $Res Function(_PhoneIssue) _then) = __$PhoneIssueCopyWithImpl;
@useResult
$Res call({
 String failureMessage
});




}
/// @nodoc
class __$PhoneIssueCopyWithImpl<$Res>
    implements _$PhoneIssueCopyWith<$Res> {
  __$PhoneIssueCopyWithImpl(this._self, this._then);

  final _PhoneIssue _self;
  final $Res Function(_PhoneIssue) _then;

/// Create a copy of PhoneAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failureMessage = null,}) {
  return _then(_PhoneIssue(
failureMessage: null == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
