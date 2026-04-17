import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/dashboard_stats.dart';
import 'revenue_chart_point.dart';
import 'stat_card.dart';

// Height of each revenue bar chart container.
const double _kChartHeight = 200;


class RevenuePanel extends StatelessWidget {
  final DashboardStats stats;

  const RevenuePanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: l.netRevenueLabel,
                value: '${stats.netRevenue.toStringAsFixed(0)} ج',
                icon: Icons.attach_money_outlined,
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: StatCard(
                title: l.avgOrderValueLabel,
                value: '${stats.aov.toStringAsFixed(0)} ج',
                icon: Icons.trending_up_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        StatCard(
          title: l.totalRefundedLabel,
          value: '${stats.totalRefunded.toStringAsFixed(0)} ج',
          icon: Icons.replay_outlined,
        ),
        const SizedBox(height: AppSpacing.large),
        _RevenueBarChart(
          title: l.dailyRevenueChartTitle,
          revenuePoints: RevenueChartPoint.daily(stats.preparedDailyRevenue),
          refundData: stats.preparedDailyRefunded,
          maxY: stats.dailyRevenueMaxY,
        ),
        const SizedBox(height: AppSpacing.large),
        _RevenueBarChart(
          title: l.monthlyRevenueChartTitle,
          revenuePoints: RevenueChartPoint.monthly(
            stats.preparedMonthlyRevenue,
          ),
          refundData: stats.preparedMonthlyRefunded,
          maxY: stats.monthlyRevenueMaxY,
        ),
      ],
    );
  }
}

class _RevenueBarChart extends StatelessWidget {
  final String title;
  final List<RevenueChartPoint> revenuePoints;
  final List<MapEntry<String, double>> refundData;
  final double maxY;

  const _RevenueBarChart({
    required this.title,
    required this.revenuePoints,
    required this.refundData,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final hasRefund = refundData.isNotEmpty;
    // Build a lookup for refund values keyed by date string.
    final refundMap = {for (final e in refundData) e.key: e.value};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.productName),
            ),
            if (hasRefund) ...[
              _LegendDot(color: AppColors.goldRoyal, label: l.revenueChartLabel),
              const SizedBox(width: AppSpacing.small),
              _LegendDot(color: AppColors.refundPurple, label: l.refundChartLabel),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        Container(
          height: _kChartHeight,
          padding: const EdgeInsets.all(AppSpacing.medium),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppColors.cardShadow,
          ),
          child: revenuePoints.isEmpty
              ? Center(
                  child: Text(
                    l.noDataAvailable,
                    style: AppTextStyles.bodyDescription,
                  ),
                )
              : BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final label = revenuePoints[groupIndex].tooltipKey;
                          final value = rod.toY.toStringAsFixed(0);
                          final suffix = rodIndex == 0
                              ? l.revenueChartLabel
                              : l.refundChartLabel;
                          return BarTooltipItem(
                            '$label\n$value ج ($suffix)',
                            AppTextStyles.bodyDescription.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 11,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            final label = index >= 0 &&
                                    index < revenuePoints.length
                                ? revenuePoints[index].label
                                : '';
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(
                                label,
                                style: AppTextStyles.navLabel.copyWith(
                                  color: AppColors.textSubtle,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(
                                value.toStringAsFixed(0),
                                style: AppTextStyles.navLabel.copyWith(
                                  color: AppColors.textSubtle,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) => const FlLine(
                        color: AppColors.chartGridLine,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(
                          color: AppColors.chartGridLine,
                          width: 1,
                        ),
                      ),
                    ),
                    barGroups: revenuePoints.asMap().entries.map((e) {
                      final refundValue = refundMap[e.value.tooltipKey] ?? 0.0;
                      final barWidth = revenuePoints.length > 20 ? 4.0 : 8.0;
                      return BarChartGroupData(
                        x: e.key,
                        groupVertically: false,
                        barRods: [
                          BarChartRodData(
                            toY: e.value.value,
                            color: AppColors.goldRoyal,
                            width: barWidth,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          if (hasRefund)
                            BarChartRodData(
                              toY: refundValue,
                              color: AppColors.refundPurple,
                              width: barWidth,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.navLabel.copyWith(
            color: AppColors.textSubtle,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
