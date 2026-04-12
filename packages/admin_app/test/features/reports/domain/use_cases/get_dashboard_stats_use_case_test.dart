import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/reports/domain/entities/dashboard_stats.dart';
import 'package:admin/features/reports/domain/entities/out_of_stock_product.dart';
import 'package:admin/features/reports/domain/repo/reports_repo.dart';
import 'package:admin/features/reports/domain/use_cases/get_dashboard_stats_use_case.dart';

class _FakeReportsRepo implements ReportsRepo {
  final Either<ServerFailure, DashboardStats> statsResult;

  _FakeReportsRepo(this.statsResult);

  @override
  Future<Either<ServerFailure, DashboardStats>> getDashboardStats() async =>
      statsResult;

  @override
  Future<Either<ServerFailure, List<OutOfStockProduct>>>
      getOutOfStockProducts() async => const Right([]);
}

DashboardStats _fakeDashboardStats() => DashboardStats(
      totalRevenue: 1000,
      totalOrders: 10,
      totalCustomers: 5,
      outOfStockCount: 2,
      ordersByStatus: {'pending': 3, 'confirmed': 2, 'cancelled': 1},
      dailyRevenue: {'2026-03-01': 100.0},
      monthlyRevenue: {'2026-03': 1000.0},
      dailyRefunded: {'2026-03-01': 20.0},
      monthlyRefunded: {'2026-03': 200.0},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026, 3, 29),
    );

void main() {
  // ── Success / failure ──────────────────────────────────────────────────────

  test('returns DashboardStats on success', () async {
    final stats = _fakeDashboardStats();
    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(stats)),
    );

    final result = await useCase();

    expect(result.isRight(), true);
    result.fold(
      (_) => fail('expected Right'),
      (s) => expect(s.totalRevenue, 1000),
    );
  });

  test('returns failure on error', () async {
    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(
        Left(const ServerFailure(code: 'not-found')),
      ),
    );

    final result = await useCase();

    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f.code, 'not-found'),
      (_) => fail('expected Left'),
    );
  });

  // ── Entity getters ─────────────────────────────────────────────────────────

  test('aov is computed correctly', () {
    final stats = _fakeDashboardStats();
    expect(stats.aov, 100.0);
  });

  test('aov is 0 when totalOrders is 0', () {
    final stats = DashboardStats(
      totalRevenue: 500,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      dailyRevenue: const {},
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );
    expect(stats.aov, 0);
  });

  test('cancellationRate uses correct formula', () {
    final stats = DashboardStats(
      totalRevenue: 0,
      totalOrders: 9,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: {'cancelled': 1},
      dailyRevenue: const {},
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );
    // 1 / (9 + 1) = 0.1
    expect(stats.cancellationRate, closeTo(0.1, 0.001));
  });

  test('cancellationRatePercent is cancellationRate × 100', () {
    final stats = DashboardStats(
      totalRevenue: 0,
      totalOrders: 9,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: {'cancelled': 1},
      dailyRevenue: const {},
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );
    expect(stats.cancellationRatePercent, closeTo(10.0, 0.01));
  });

  // ── Use-case data preparation ──────────────────────────────────────────────

  test('use case returns prepared daily revenue sorted chronologically', () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      // Intentionally out of order — use case must sort
      dailyRevenue: {
        '2026-03-05': 200.0,
        '2026-03-03': 100.0,
        '2026-03-04': 150.0,
      },
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      (s) {
        final keys = s.preparedDailyRevenue.map((e) => e.key).toList();
        expect(keys, ['2026-03-03', '2026-03-04', '2026-03-05']);
        expect(s.preparedDailyRevenue[0].value, 100.0);
        expect(s.preparedDailyRevenue[2].value, 200.0);
      },
    );
  });

  test('use case fills any date gaps in daily revenue with 0', () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      // Gap on 2026-03-04 should be filled
      dailyRevenue: {
        '2026-03-03': 100.0,
        '2026-03-05': 200.0,
      },
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      (s) {
        final gap = s.preparedDailyRevenue.firstWhere(
          (e) => e.key == '2026-03-04',
        );
        expect(gap.value, 0.0);
      },
    );
  });

  test('use case sets dailyRevenueMaxY with headroom above the max value',
      () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      dailyRevenue: {'2026-03-01': 400.0, '2026-03-02': 600.0},
      monthlyRevenue: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      // Max value is 600. maxY must be strictly above it with some headroom
      // (implementation uses ×1.2 = 720, capped at a round number).
      (s) => expect(s.dailyRevenueMaxY, greaterThan(600.0)),
    );
  });

  test('use case prepares dailyRefunded sorted chronologically', () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      dailyRevenue: const {},
      monthlyRevenue: const {},
      dailyRefunded: {
        '2026-03-05': 50.0,
        '2026-03-03': 30.0,
      },
      monthlyRefunded: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      (s) {
        final keys = s.preparedDailyRefunded.map((e) => e.key).toList();
        expect(keys, ['2026-03-03', '2026-03-04', '2026-03-05']);
        expect(s.preparedDailyRefunded[0].value, 30.0);
        expect(s.preparedDailyRefunded[2].value, 50.0);
      },
    );
  });

  test('dailyRevenueMaxY accounts for refund values exceeding revenue', () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      dailyRevenue: {'2026-03-01': 100.0},
      monthlyRevenue: const {},
      dailyRefunded: {'2026-03-01': 800.0},
      monthlyRefunded: const {},
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      // Max value across both is 800 — maxY must be above that.
      (s) => expect(s.dailyRevenueMaxY, greaterThan(800.0)),
    );
  });

  test('use case returns prepared monthly revenue sorted chronologically',
      () async {
    final raw = DashboardStats(
      totalRevenue: 0,
      totalOrders: 0,
      totalCustomers: 0,
      outOfStockCount: 0,
      ordersByStatus: const {},
      dailyRevenue: const {},
      monthlyRevenue: {
        '2026-03': 3000.0,
        '2026-01': 1000.0,
        '2026-02': 2000.0,
      },
      topSelling: const [],
      topSpenders: const [],
      lastUpdatedAt: DateTime(2026),
    );

    final useCase = GetDashboardStatsUseCase(
      repo: _FakeReportsRepo(Right(raw)),
    );
    final result = await useCase();

    result.fold(
      (_) => fail('expected Right'),
      (s) {
        final keys = s.preparedMonthlyRevenue.map((e) => e.key).toList();
        expect(keys, ['2026-01', '2026-02', '2026-03']);
      },
    );
  });
}
