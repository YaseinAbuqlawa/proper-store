// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardStatsModel {

 double get totalRevenue; double get totalRefunded; int get totalOrders; int get refundedOrders; int get totalCustomers; int get outOfStockCount; Map<String, int> get ordersByStatus; Map<String, double> get dailyRevenue; Map<String, double> get monthlyRevenue; Map<String, double> get dailyRefunded; Map<String, double> get monthlyRefunded; List<TopSellingItemModel> get topSelling; List<TopSpenderModel> get topSpenders;@TimestampConverter() DateTime get lastUpdatedAt;
/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsModelCopyWith<DashboardStatsModel> get copyWith => _$DashboardStatsModelCopyWithImpl<DashboardStatsModel>(this as DashboardStatsModel, _$identity);

  /// Serializes this DashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStatsModel&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.refundedOrders, refundedOrders) || other.refundedOrders == refundedOrders)&&(identical(other.totalCustomers, totalCustomers) || other.totalCustomers == totalCustomers)&&(identical(other.outOfStockCount, outOfStockCount) || other.outOfStockCount == outOfStockCount)&&const DeepCollectionEquality().equals(other.ordersByStatus, ordersByStatus)&&const DeepCollectionEquality().equals(other.dailyRevenue, dailyRevenue)&&const DeepCollectionEquality().equals(other.monthlyRevenue, monthlyRevenue)&&const DeepCollectionEquality().equals(other.dailyRefunded, dailyRefunded)&&const DeepCollectionEquality().equals(other.monthlyRefunded, monthlyRefunded)&&const DeepCollectionEquality().equals(other.topSelling, topSelling)&&const DeepCollectionEquality().equals(other.topSpenders, topSpenders)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalRefunded,totalOrders,refundedOrders,totalCustomers,outOfStockCount,const DeepCollectionEquality().hash(ordersByStatus),const DeepCollectionEquality().hash(dailyRevenue),const DeepCollectionEquality().hash(monthlyRevenue),const DeepCollectionEquality().hash(dailyRefunded),const DeepCollectionEquality().hash(monthlyRefunded),const DeepCollectionEquality().hash(topSelling),const DeepCollectionEquality().hash(topSpenders),lastUpdatedAt);

@override
String toString() {
  return 'DashboardStatsModel(totalRevenue: $totalRevenue, totalRefunded: $totalRefunded, totalOrders: $totalOrders, refundedOrders: $refundedOrders, totalCustomers: $totalCustomers, outOfStockCount: $outOfStockCount, ordersByStatus: $ordersByStatus, dailyRevenue: $dailyRevenue, monthlyRevenue: $monthlyRevenue, dailyRefunded: $dailyRefunded, monthlyRefunded: $monthlyRefunded, topSelling: $topSelling, topSpenders: $topSpenders, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $DashboardStatsModelCopyWith<$Res>  {
  factory $DashboardStatsModelCopyWith(DashboardStatsModel value, $Res Function(DashboardStatsModel) _then) = _$DashboardStatsModelCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, double totalRefunded, int totalOrders, int refundedOrders, int totalCustomers, int outOfStockCount, Map<String, int> ordersByStatus, Map<String, double> dailyRevenue, Map<String, double> monthlyRevenue, Map<String, double> dailyRefunded, Map<String, double> monthlyRefunded, List<TopSellingItemModel> topSelling, List<TopSpenderModel> topSpenders,@TimestampConverter() DateTime lastUpdatedAt
});




}
/// @nodoc
class _$DashboardStatsModelCopyWithImpl<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  _$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final DashboardStatsModel _self;
  final $Res Function(DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalRefunded = null,Object? totalOrders = null,Object? refundedOrders = null,Object? totalCustomers = null,Object? outOfStockCount = null,Object? ordersByStatus = null,Object? dailyRevenue = null,Object? monthlyRevenue = null,Object? dailyRefunded = null,Object? monthlyRefunded = null,Object? topSelling = null,Object? topSpenders = null,Object? lastUpdatedAt = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,refundedOrders: null == refundedOrders ? _self.refundedOrders : refundedOrders // ignore: cast_nullable_to_non_nullable
as int,totalCustomers: null == totalCustomers ? _self.totalCustomers : totalCustomers // ignore: cast_nullable_to_non_nullable
as int,outOfStockCount: null == outOfStockCount ? _self.outOfStockCount : outOfStockCount // ignore: cast_nullable_to_non_nullable
as int,ordersByStatus: null == ordersByStatus ? _self.ordersByStatus : ordersByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,dailyRevenue: null == dailyRevenue ? _self.dailyRevenue : dailyRevenue // ignore: cast_nullable_to_non_nullable
as Map<String, double>,monthlyRevenue: null == monthlyRevenue ? _self.monthlyRevenue : monthlyRevenue // ignore: cast_nullable_to_non_nullable
as Map<String, double>,dailyRefunded: null == dailyRefunded ? _self.dailyRefunded : dailyRefunded // ignore: cast_nullable_to_non_nullable
as Map<String, double>,monthlyRefunded: null == monthlyRefunded ? _self.monthlyRefunded : monthlyRefunded // ignore: cast_nullable_to_non_nullable
as Map<String, double>,topSelling: null == topSelling ? _self.topSelling : topSelling // ignore: cast_nullable_to_non_nullable
as List<TopSellingItemModel>,topSpenders: null == topSpenders ? _self.topSpenders : topSpenders // ignore: cast_nullable_to_non_nullable
as List<TopSpenderModel>,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardStatsModel].
extension DashboardStatsModelPatterns on DashboardStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalRevenue,  double totalRefunded,  int totalOrders,  int refundedOrders,  int totalCustomers,  int outOfStockCount,  Map<String, int> ordersByStatus,  Map<String, double> dailyRevenue,  Map<String, double> monthlyRevenue,  Map<String, double> dailyRefunded,  Map<String, double> monthlyRefunded,  List<TopSellingItemModel> topSelling,  List<TopSpenderModel> topSpenders, @TimestampConverter()  DateTime lastUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.totalRevenue,_that.totalRefunded,_that.totalOrders,_that.refundedOrders,_that.totalCustomers,_that.outOfStockCount,_that.ordersByStatus,_that.dailyRevenue,_that.monthlyRevenue,_that.dailyRefunded,_that.monthlyRefunded,_that.topSelling,_that.topSpenders,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalRevenue,  double totalRefunded,  int totalOrders,  int refundedOrders,  int totalCustomers,  int outOfStockCount,  Map<String, int> ordersByStatus,  Map<String, double> dailyRevenue,  Map<String, double> monthlyRevenue,  Map<String, double> dailyRefunded,  Map<String, double> monthlyRefunded,  List<TopSellingItemModel> topSelling,  List<TopSpenderModel> topSpenders, @TimestampConverter()  DateTime lastUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel():
return $default(_that.totalRevenue,_that.totalRefunded,_that.totalOrders,_that.refundedOrders,_that.totalCustomers,_that.outOfStockCount,_that.ordersByStatus,_that.dailyRevenue,_that.monthlyRevenue,_that.dailyRefunded,_that.monthlyRefunded,_that.topSelling,_that.topSpenders,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalRevenue,  double totalRefunded,  int totalOrders,  int refundedOrders,  int totalCustomers,  int outOfStockCount,  Map<String, int> ordersByStatus,  Map<String, double> dailyRevenue,  Map<String, double> monthlyRevenue,  Map<String, double> dailyRefunded,  Map<String, double> monthlyRefunded,  List<TopSellingItemModel> topSelling,  List<TopSpenderModel> topSpenders, @TimestampConverter()  DateTime lastUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.totalRevenue,_that.totalRefunded,_that.totalOrders,_that.refundedOrders,_that.totalCustomers,_that.outOfStockCount,_that.ordersByStatus,_that.dailyRevenue,_that.monthlyRevenue,_that.dailyRefunded,_that.monthlyRefunded,_that.topSelling,_that.topSpenders,_that.lastUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardStatsModel extends DashboardStatsModel {
  const _DashboardStatsModel({this.totalRevenue = 0.0, this.totalRefunded = 0.0, this.totalOrders = 0, this.refundedOrders = 0, this.totalCustomers = 0, this.outOfStockCount = 0, final  Map<String, int> ordersByStatus = const {}, final  Map<String, double> dailyRevenue = const {}, final  Map<String, double> monthlyRevenue = const {}, final  Map<String, double> dailyRefunded = const {}, final  Map<String, double> monthlyRefunded = const {}, final  List<TopSellingItemModel> topSelling = const [], final  List<TopSpenderModel> topSpenders = const [], @TimestampConverter() required this.lastUpdatedAt}): _ordersByStatus = ordersByStatus,_dailyRevenue = dailyRevenue,_monthlyRevenue = monthlyRevenue,_dailyRefunded = dailyRefunded,_monthlyRefunded = monthlyRefunded,_topSelling = topSelling,_topSpenders = topSpenders,super._();
  factory _DashboardStatsModel.fromJson(Map<String, dynamic> json) => _$DashboardStatsModelFromJson(json);

@override@JsonKey() final  double totalRevenue;
@override@JsonKey() final  double totalRefunded;
@override@JsonKey() final  int totalOrders;
@override@JsonKey() final  int refundedOrders;
@override@JsonKey() final  int totalCustomers;
@override@JsonKey() final  int outOfStockCount;
 final  Map<String, int> _ordersByStatus;
@override@JsonKey() Map<String, int> get ordersByStatus {
  if (_ordersByStatus is EqualUnmodifiableMapView) return _ordersByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ordersByStatus);
}

 final  Map<String, double> _dailyRevenue;
@override@JsonKey() Map<String, double> get dailyRevenue {
  if (_dailyRevenue is EqualUnmodifiableMapView) return _dailyRevenue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dailyRevenue);
}

 final  Map<String, double> _monthlyRevenue;
@override@JsonKey() Map<String, double> get monthlyRevenue {
  if (_monthlyRevenue is EqualUnmodifiableMapView) return _monthlyRevenue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_monthlyRevenue);
}

 final  Map<String, double> _dailyRefunded;
@override@JsonKey() Map<String, double> get dailyRefunded {
  if (_dailyRefunded is EqualUnmodifiableMapView) return _dailyRefunded;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dailyRefunded);
}

 final  Map<String, double> _monthlyRefunded;
@override@JsonKey() Map<String, double> get monthlyRefunded {
  if (_monthlyRefunded is EqualUnmodifiableMapView) return _monthlyRefunded;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_monthlyRefunded);
}

 final  List<TopSellingItemModel> _topSelling;
@override@JsonKey() List<TopSellingItemModel> get topSelling {
  if (_topSelling is EqualUnmodifiableListView) return _topSelling;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topSelling);
}

 final  List<TopSpenderModel> _topSpenders;
@override@JsonKey() List<TopSpenderModel> get topSpenders {
  if (_topSpenders is EqualUnmodifiableListView) return _topSpenders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topSpenders);
}

@override@TimestampConverter() final  DateTime lastUpdatedAt;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsModelCopyWith<_DashboardStatsModel> get copyWith => __$DashboardStatsModelCopyWithImpl<_DashboardStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStatsModel&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.refundedOrders, refundedOrders) || other.refundedOrders == refundedOrders)&&(identical(other.totalCustomers, totalCustomers) || other.totalCustomers == totalCustomers)&&(identical(other.outOfStockCount, outOfStockCount) || other.outOfStockCount == outOfStockCount)&&const DeepCollectionEquality().equals(other._ordersByStatus, _ordersByStatus)&&const DeepCollectionEquality().equals(other._dailyRevenue, _dailyRevenue)&&const DeepCollectionEquality().equals(other._monthlyRevenue, _monthlyRevenue)&&const DeepCollectionEquality().equals(other._dailyRefunded, _dailyRefunded)&&const DeepCollectionEquality().equals(other._monthlyRefunded, _monthlyRefunded)&&const DeepCollectionEquality().equals(other._topSelling, _topSelling)&&const DeepCollectionEquality().equals(other._topSpenders, _topSpenders)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalRefunded,totalOrders,refundedOrders,totalCustomers,outOfStockCount,const DeepCollectionEquality().hash(_ordersByStatus),const DeepCollectionEquality().hash(_dailyRevenue),const DeepCollectionEquality().hash(_monthlyRevenue),const DeepCollectionEquality().hash(_dailyRefunded),const DeepCollectionEquality().hash(_monthlyRefunded),const DeepCollectionEquality().hash(_topSelling),const DeepCollectionEquality().hash(_topSpenders),lastUpdatedAt);

@override
String toString() {
  return 'DashboardStatsModel(totalRevenue: $totalRevenue, totalRefunded: $totalRefunded, totalOrders: $totalOrders, refundedOrders: $refundedOrders, totalCustomers: $totalCustomers, outOfStockCount: $outOfStockCount, ordersByStatus: $ordersByStatus, dailyRevenue: $dailyRevenue, monthlyRevenue: $monthlyRevenue, dailyRefunded: $dailyRefunded, monthlyRefunded: $monthlyRefunded, topSelling: $topSelling, topSpenders: $topSpenders, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsModelCopyWith<$Res> implements $DashboardStatsModelCopyWith<$Res> {
  factory _$DashboardStatsModelCopyWith(_DashboardStatsModel value, $Res Function(_DashboardStatsModel) _then) = __$DashboardStatsModelCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, double totalRefunded, int totalOrders, int refundedOrders, int totalCustomers, int outOfStockCount, Map<String, int> ordersByStatus, Map<String, double> dailyRevenue, Map<String, double> monthlyRevenue, Map<String, double> dailyRefunded, Map<String, double> monthlyRefunded, List<TopSellingItemModel> topSelling, List<TopSpenderModel> topSpenders,@TimestampConverter() DateTime lastUpdatedAt
});




}
/// @nodoc
class __$DashboardStatsModelCopyWithImpl<$Res>
    implements _$DashboardStatsModelCopyWith<$Res> {
  __$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final _DashboardStatsModel _self;
  final $Res Function(_DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalRefunded = null,Object? totalOrders = null,Object? refundedOrders = null,Object? totalCustomers = null,Object? outOfStockCount = null,Object? ordersByStatus = null,Object? dailyRevenue = null,Object? monthlyRevenue = null,Object? dailyRefunded = null,Object? monthlyRefunded = null,Object? topSelling = null,Object? topSpenders = null,Object? lastUpdatedAt = null,}) {
  return _then(_DashboardStatsModel(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,refundedOrders: null == refundedOrders ? _self.refundedOrders : refundedOrders // ignore: cast_nullable_to_non_nullable
as int,totalCustomers: null == totalCustomers ? _self.totalCustomers : totalCustomers // ignore: cast_nullable_to_non_nullable
as int,outOfStockCount: null == outOfStockCount ? _self.outOfStockCount : outOfStockCount // ignore: cast_nullable_to_non_nullable
as int,ordersByStatus: null == ordersByStatus ? _self._ordersByStatus : ordersByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,dailyRevenue: null == dailyRevenue ? _self._dailyRevenue : dailyRevenue // ignore: cast_nullable_to_non_nullable
as Map<String, double>,monthlyRevenue: null == monthlyRevenue ? _self._monthlyRevenue : monthlyRevenue // ignore: cast_nullable_to_non_nullable
as Map<String, double>,dailyRefunded: null == dailyRefunded ? _self._dailyRefunded : dailyRefunded // ignore: cast_nullable_to_non_nullable
as Map<String, double>,monthlyRefunded: null == monthlyRefunded ? _self._monthlyRefunded : monthlyRefunded // ignore: cast_nullable_to_non_nullable
as Map<String, double>,topSelling: null == topSelling ? _self._topSelling : topSelling // ignore: cast_nullable_to_non_nullable
as List<TopSellingItemModel>,topSpenders: null == topSpenders ? _self._topSpenders : topSpenders // ignore: cast_nullable_to_non_nullable
as List<TopSpenderModel>,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
