import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/dashboard_stats.dart';
import 'stat_card.dart';

// Diameter of the order-status pie chart.
const double _kPieChartSize = 160;

class OrdersPanel extends StatelessWidget {
  final DashboardStats stats;

  const OrdersPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final cancellationPct =
        '${stats.cancellationRatePercent.toStringAsFixed(1)}%';
    final refundPct = '${stats.refundRatePercent.toStringAsFixed(1)}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: l.totalOrdersLabel,
                value: stats.totalOrders.toString(),
                icon: Icons.receipt_long_outlined,
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: StatCard(
                title: l.cancellationRateLabel,
                value: cancellationPct,
                icon: Icons.cancel_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        StatCard(
          title: l.refundRateLabel,
          value: refundPct,
          icon: Icons.replay_outlined,
        ),
        const SizedBox(height: AppSpacing.large),
        Text(l.ordersStatusChartTitle, style: AppTextStyles.productName),
        const SizedBox(height: AppSpacing.medium),
        _OrdersStatusChart(ordersByStatus: stats.ordersByStatus),
      ],
    );
  }
}

class _OrdersStatusChart extends StatelessWidget {
  final Map<String, int> ordersByStatus;

  const _OrdersStatusChart({required this.ordersByStatus});

  static const _statusColors = {
    'pending': Color(0xFFFFC107),
    'confirmed': Color(0xFF42A5F5),
    'shipped': Color(0xFFFF7043),
    'delivered': Color(0xFF66BB6A),
    'refunded': Color(0xFF7E57C2),
    'cancelled': Color(0xFFEF5350),
  };

  static const _statusOrder = [
    'pending',
    'confirmed',
    'shipped',
    'delivered',
    'refunded',
    'cancelled',
  ];

  /// Maps a Firestore status key to its localized display label.
  static String _statusLabel(String key, S l) => switch (key) {
    'pending' => l.orderStatusPending,
    'confirmed' => l.orderStatusConfirmed,
    'shipped' => l.orderStatusShipped,
    'delivered' => l.orderStatusDelivered,
    'refunded' => l.orderStatusRefunded,
    'cancelled' => l.orderStatusCancelled,
    _ => key,
  };

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final entries = _statusOrder
        .map((k) => MapEntry(k, ordersByStatus[k] ?? 0))
        .toList();

    final total = entries.fold(0, (sum, e) => sum + e.value);

    if (total == 0) {
      return Center(
        child: Text(
          S.of(context).noDataAvailable,
          style: AppTextStyles.bodyDescription,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          SizedBox(
            height: _kPieChartSize,
            width: _kPieChartSize,
            child: PieChart(
              PieChartData(
                sections: entries.map((e) {
                  final color = _statusColors[e.key] ?? AppColors.textSubtle;
                  return PieChartSectionData(
                    value: e.value.toDouble(),
                    color: color,
                    radius: 55,
                    title: e.value > 0
                        ? '${(e.value / total * 100).toStringAsFixed(0)}%'
                        : '',
                    titleStyle: AppTextStyles.navLabel.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 10,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 30,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.large),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entries.map((e) {
                final color = _statusColors[e.key] ?? AppColors.textSubtle;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_statusLabel(e.key, l)}: ${e.value}',
                        style: AppTextStyles.bodyDescription,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
