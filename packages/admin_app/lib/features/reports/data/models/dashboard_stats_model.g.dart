// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    _DashboardStatsModel(
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      totalRefunded: (json['totalRefunded'] as num?)?.toDouble() ?? 0.0,
      totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      refundedOrders: (json['refundedOrders'] as num?)?.toInt() ?? 0,
      totalCustomers: (json['totalCustomers'] as num?)?.toInt() ?? 0,
      outOfStockCount: (json['outOfStockCount'] as num?)?.toInt() ?? 0,
      ordersByStatus:
          (json['ordersByStatus'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      dailyRevenue:
          (json['dailyRevenue'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      monthlyRevenue:
          (json['monthlyRevenue'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      dailyRefunded:
          (json['dailyRefunded'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      monthlyRefunded:
          (json['monthlyRefunded'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      topSelling:
          (json['topSelling'] as List<dynamic>?)
              ?.map(
                (e) => TopSellingItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      topSpenders:
          (json['topSpenders'] as List<dynamic>?)
              ?.map((e) => TopSpenderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdatedAt: const TimestampConverter().fromJson(json['lastUpdatedAt']),
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
  _DashboardStatsModel instance,
) => <String, dynamic>{
  'totalRevenue': instance.totalRevenue,
  'totalRefunded': instance.totalRefunded,
  'totalOrders': instance.totalOrders,
  'refundedOrders': instance.refundedOrders,
  'totalCustomers': instance.totalCustomers,
  'outOfStockCount': instance.outOfStockCount,
  'ordersByStatus': instance.ordersByStatus,
  'dailyRevenue': instance.dailyRevenue,
  'monthlyRevenue': instance.monthlyRevenue,
  'dailyRefunded': instance.dailyRefunded,
  'monthlyRefunded': instance.monthlyRefunded,
  'topSelling': instance.topSelling,
  'topSpenders': instance.topSpenders,
  'lastUpdatedAt': const TimestampConverter().toJson(instance.lastUpdatedAt),
};
