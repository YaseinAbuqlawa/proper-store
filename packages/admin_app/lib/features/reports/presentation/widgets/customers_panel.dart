import 'package:flutter/material.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/top_spender.dart';
import 'stat_card.dart';

class CustomersPanel extends StatelessWidget {
  final DashboardStats stats;

  const CustomersPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatCard(
          title: l.totalCustomersLabel,
          value: stats.totalCustomers.toString(),
          icon: Icons.people_outline,
        ),
        const SizedBox(height: AppSpacing.large),
        Text(l.topSpendersLabel, style: AppTextStyles.productName),
        const SizedBox(height: AppSpacing.medium),
        if (stats.topSpenders.isEmpty)
          Text(
            l.noDataAvailable,
            style: AppTextStyles.bodyDescription,
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius:
                  BorderRadius.circular(AppSpacing.borderRadiusMedium),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              children: [
                for (int i = 0; i < stats.topSpenders.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  _SpenderRow(spender: stats.topSpenders[i], rank: i + 1),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _SpenderRow extends StatelessWidget {
  final TopSpender spender;
  final int rank;

  const _SpenderRow({required this.spender, required this.rank});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '#$rank',
              style: AppTextStyles.navLabel.copyWith(
                color: AppColors.goldRoyal,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          Expanded(
            child: Text(
              spender.name,
              style: AppTextStyles.productName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${spender.totalSpent.toStringAsFixed(0)} ج',
                style: AppTextStyles.productName.copyWith(
                  color: AppColors.goldRoyal,
                ),
              ),
              Text(
                l.orderCountLabel(spender.orderCount),
                style: AppTextStyles.bodyDescription,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
