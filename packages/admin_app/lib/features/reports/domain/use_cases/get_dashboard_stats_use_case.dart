import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import '../entities/dashboard_stats.dart';
import '../repo/reports_repo.dart';

@injectable
class GetDashboardStatsUseCase {
  final ReportsRepo repo;

  const GetDashboardStatsUseCase({required this.repo});

  Future<Either<ServerFailure, DashboardStats>> call() async {
    final result = await repo.getDashboardStats();
    return result.map(_withPreparedData);
  }

  /// Augments a raw [DashboardStats] with all presentation-ready computed
  /// fields so that no widget ever runs sorting, gap-filling, or folding
  /// inside build().
  static DashboardStats _withPreparedData(DashboardStats raw) {
    final daily = _prepareDailyRevenue(raw.dailyRevenue);
    final monthly = _prepareMonthlyRevenue(raw.monthlyRevenue);
    final dailyRefunded = _prepareDailyRevenue(raw.dailyRefunded);
    final monthlyRefunded = _prepareMonthlyRevenue(raw.monthlyRefunded);
    return DashboardStats(
      refundedOrders: raw.refundedOrders,
      totalRefunded: raw.totalRefunded,
      totalRevenue: raw.totalRevenue,
      totalOrders: raw.totalOrders,
      totalCustomers: raw.totalCustomers,
      outOfStockCount: raw.outOfStockCount,
      ordersByStatus: raw.ordersByStatus,
      dailyRevenue: raw.dailyRevenue,
      monthlyRevenue: raw.monthlyRevenue,
      dailyRefunded: raw.dailyRefunded,
      monthlyRefunded: raw.monthlyRefunded,
      topSelling: raw.topSelling,
      topSpenders: raw.topSpenders,
      lastUpdatedAt: raw.lastUpdatedAt,
      preparedDailyRevenue: daily,
      preparedMonthlyRevenue: monthly,
      preparedDailyRefunded: dailyRefunded,
      preparedMonthlyRefunded: monthlyRefunded,
      dailyRevenueMaxY: _computeMaxY([...daily, ...dailyRefunded]),
      monthlyRevenueMaxY: _computeMaxY([...monthly, ...monthlyRefunded]),
    );
  }

  /// Sorts by date key, gap-fills missing days, caps at the last 30 entries.
  static List<MapEntry<String, double>> _prepareDailyRevenue(
    Map<String, double> dailyRevenue,
  ) {
    if (dailyRevenue.isEmpty) return const [];

    final sorted = dailyRevenue.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final last30 = sorted.length > 30
        ? sorted.sublist(sorted.length - 30)
        : sorted;

    final result = <MapEntry<String, double>>[];
    var current = DateTime.parse('${last30.first.key}T00:00:00');
    final end = DateTime.parse('${last30.last.key}T00:00:00');

    while (!current.isAfter(end)) {
      final key =
          '${current.year}-${current.month.toString().padLeft(2, '0')}-${current.day.toString().padLeft(2, '0')}';
      result.add(MapEntry(key, dailyRevenue[key] ?? 0));
      current = current.add(const Duration(days: 1));
    }

    return result.length > 30 ? result.sublist(result.length - 30) : result;
  }

  /// Sorts by month key, gap-fills missing months, caps at the last 12 entries.
  static List<MapEntry<String, double>> _prepareMonthlyRevenue(
    Map<String, double> monthlyRevenue,
  ) {
    if (monthlyRevenue.isEmpty) return const [];

    final sorted = monthlyRevenue.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final last12 = sorted.length > 12
        ? sorted.sublist(sorted.length - 12)
        : sorted;

    final result = <MapEntry<String, double>>[];
    var currentYear = int.parse(last12.first.key.split('-')[0]);
    var currentMonth = int.parse(last12.first.key.split('-')[1]);
    final endYear = int.parse(last12.last.key.split('-')[0]);
    final endMonth = int.parse(last12.last.key.split('-')[1]);

    while (currentYear < endYear ||
        (currentYear == endYear && currentMonth <= endMonth)) {
      final key = '$currentYear-${currentMonth.toString().padLeft(2, '0')}';
      result.add(MapEntry(key, monthlyRevenue[key] ?? 0));
      currentMonth++;
      if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
      }
    }

    return result.length > 12 ? result.sublist(result.length - 12) : result;
  }

  /// Computes max Y with a 20 % headroom buffer so bar tops don't clip.
  static double _computeMaxY(List<MapEntry<String, double>> entries) {
    if (entries.isEmpty) return 100;
    final max = entries.map((e) => e.value).fold(0.0, (a, b) => a > b ? a : b);
    return max == 0 ? 100 : max * 1.2;
  }
}
