import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/dashboard_stats.dart';
import 'stat_card.dart';

// Height of each revenue bar chart container.
const double _kChartHeight = 200;

class RevenuePanel extends StatelessWidget {
  final DashboardStats stats;

  const RevenuePanel({super.key, required this.stats});

  // Static label builders — extracted here so build() does not allocate
  // closure objects on every frame.
  static String _dailyLabel(int index, List<MapEntry<String, double>> entries) {
    if (index < 0 || index >= entries.length) return '';
    final day = entries[index].key.split('-').last;
    return index % 5 == 0 ? day : '';
  }

  static String _monthlyLabel(
    int index,
    List<MapEntry<String, double>> entries,
  ) {
    if (index < 0 || index >= entries.length) return '';
    final parts = entries[index].key.split('-');
    return parts.length >= 2 ? parts[1] : '';
  }

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
                title: l.totalRevenueLabel,
                value: '${stats.totalRevenue.toStringAsFixed(0)} ج',
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
        const SizedBox(height: AppSpacing.large),
        // preparedDailyRevenue and dailyRevenueMaxY are computed once in the
        // use case and stored on the entity — no work happens in build().
        _RevenueBarChart(
          title: l.dailyRevenueChartTitle,
          data: stats.preparedDailyRevenue,
          maxY: stats.dailyRevenueMaxY,
          labelBuilder: _dailyLabel,
        ),
        const SizedBox(height: AppSpacing.large),
        _RevenueBarChart(
          title: l.monthlyRevenueChartTitle,
          data: stats.preparedMonthlyRevenue,
          maxY: stats.monthlyRevenueMaxY,
          labelBuilder: _monthlyLabel,
        ),
      ],
    );
  }
}

class _RevenueBarChart extends StatelessWidget {
  final String title;
  final List<MapEntry<String, double>> data;
  final double maxY;
  final String Function(int index, List<MapEntry<String, double>> entries)
  labelBuilder;

  const _RevenueBarChart({
    required this.title,
    required this.data,
    required this.maxY,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.productName),
        const SizedBox(height: AppSpacing.medium),
        Container(
          height: _kChartHeight,
          padding: const EdgeInsets.all(AppSpacing.medium),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppColors.cardShadow,
          ),
          child: data.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).noDataAvailable,
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
                          final label = data[groupIndex].key;
                          final value = rod.toY.toStringAsFixed(0);
                          return BarTooltipItem(
                            '$label\n$value ج',
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
                            final label = labelBuilder(value.toInt(), data);
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
                    barGroups: data.asMap().entries.map((e) {
                      return BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(
                            toY: e.value.value,
                            color: AppColors.goldRoyal,
                            width: data.length > 20 ? 6 : 12,
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
