import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store_shared/helpers/json_convertors.dart';

import '../../domain/entities/dashboard_stats.dart';
import 'top_selling_item_model.dart';
import 'top_spender_model.dart';

part 'dashboard_stats_model.freezed.dart';
part 'dashboard_stats_model.g.dart';

@freezed
abstract class DashboardStatsModel with _$DashboardStatsModel {
  const DashboardStatsModel._();

  const factory DashboardStatsModel({
    @Default(0.0) double totalRevenue,
    @Default(0.0) double totalRefunded,
    @Default(0) int totalOrders,
    @Default(0) int refundedOrders,
    @Default(0) int totalCustomers,
    @Default(0) int outOfStockCount,
    @Default({}) Map<String, int> ordersByStatus,
    @Default({}) Map<String, double> dailyRevenue,
    @Default({}) Map<String, double> monthlyRevenue,
    @Default({}) Map<String, double> dailyRefunded,
    @Default({}) Map<String, double> monthlyRefunded,
    @Default([]) List<TopSellingItemModel> topSelling,
    @Default([]) List<TopSpenderModel> topSpenders,
    @TimestampConverter() required DateTime lastUpdatedAt,
  }) = _DashboardStatsModel;

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  DashboardStats toEntity() => DashboardStats(
    totalRevenue: totalRevenue,
    totalRefunded: totalRefunded,
    totalOrders: totalOrders,
    refundedOrders: refundedOrders,
    totalCustomers: totalCustomers,
    outOfStockCount: outOfStockCount,
    ordersByStatus: ordersByStatus,
    dailyRevenue: dailyRevenue,
    monthlyRevenue: monthlyRevenue,
    dailyRefunded: dailyRefunded,
    monthlyRefunded: monthlyRefunded,
    topSelling: topSelling.map((m) => m.toEntity()).toList(),
    topSpenders: topSpenders.map((m) => m.toEntity()).toList(),
    lastUpdatedAt: lastUpdatedAt,
  );
}
