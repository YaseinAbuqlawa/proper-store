import 'top_selling_item.dart';
import 'top_spender.dart';

class DashboardStats {
  final double totalRevenue;
  // Excludes cancelled orders (stored that way by Cloud Function).
  // See cancellationRate getter.
  final int totalOrders;
  final int totalCustomers;
  final int outOfStockCount;
  final Map<String, int> ordersByStatus;
  final Map<String, double> dailyRevenue;
  final Map<String, double> monthlyRevenue;
  final List<TopSellingItem> topSelling;
  final List<TopSpender> topSpenders;
  final DateTime lastUpdatedAt;

  /// Pre-sorted, gap-filled daily revenue entries capped at 30 days.
  /// Populated by [GetDashboardStatsUseCase]; defaults to empty.
  final List<MapEntry<String, double>> preparedDailyRevenue;

  /// Pre-sorted, gap-filled monthly revenue entries capped at 12 months.
  /// Populated by [GetDashboardStatsUseCase]; defaults to empty.
  final List<MapEntry<String, double>> preparedMonthlyRevenue;

  /// Max Y axis value (with headroom) for the daily revenue chart.
  /// Computed by [GetDashboardStatsUseCase]; defaults to 100.
  final double dailyRevenueMaxY;

  /// Max Y axis value (with headroom) for the monthly revenue chart.
  /// Computed by [GetDashboardStatsUseCase]; defaults to 100.
  final double monthlyRevenueMaxY;

  const DashboardStats({
    required this.totalRevenue,
    required this.totalOrders,
    required this.totalCustomers,
    required this.outOfStockCount,
    required this.ordersByStatus,
    required this.dailyRevenue,
    required this.monthlyRevenue,
    required this.topSelling,
    required this.topSpenders,
    required this.lastUpdatedAt,
    this.preparedDailyRevenue = const [],
    this.preparedMonthlyRevenue = const [],
    this.dailyRevenueMaxY = 100,
    this.monthlyRevenueMaxY = 100,
  });

  double get aov => totalOrders > 0 ? totalRevenue / totalOrders : 0;

  int get cancelledCount => ordersByStatus['cancelled'] ?? 0;

  // totalOrders excludes cancelled; add cancelledCount back for the true total.
  double get cancellationRate {
    final total = totalOrders + cancelledCount;
    return total > 0 ? cancelledCount / total : 0;
  }

  /// Cancellation rate expressed as a percentage (0–100) ready for display.
  double get cancellationRatePercent => cancellationRate * 100;
}
