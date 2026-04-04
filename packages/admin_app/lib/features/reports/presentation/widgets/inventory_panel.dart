import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/top_selling_item.dart';
import 'stat_card.dart';

// Thumbnail size for the top-selling item image.
const double _kThumbnailSize = 40;

/// Displays the out-of-stock count stat card and the top-selling items list.
///
/// The OOS product detail list is a separate concern rendered by
/// [OutOfStockPanel] — this widget has no knowledge of it.
class InventoryPanel extends StatelessWidget {
  final DashboardStats stats;

  const InventoryPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.topSellersLabel, style: AppTextStyles.productName),
        const SizedBox(height: AppSpacing.medium),
        if (stats.topSelling.isEmpty)
          Text(l.noDataAvailable, style: AppTextStyles.bodyDescription)
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(
                AppSpacing.borderRadiusMedium,
              ),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              children: [
                for (int i = 0; i < stats.topSelling.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  _TopSellingRow(item: stats.topSelling[i], rank: i + 1),
                ],
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.large),
        StatCard(
          title: l.outOfStockLabel,
          value: stats.outOfStockCount.toString(),
          icon: Icons.inventory_2_outlined,
        ),
      ],
    );
  }
}

class _TopSellingRow extends StatelessWidget {
  final TopSellingItem item;
  final int rank;

  const _TopSellingRow({required this.item, required this.rank});

  @override
  Widget build(BuildContext context) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: _kThumbnailSize,
              height: _kThumbnailSize,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => Container(
                width: _kThumbnailSize,
                height: _kThumbnailSize,
                color: AppColors.lightBackground,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  size: 20,
                  color: AppColors.textSubtle,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: AppTextStyles.bodyDescription.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.variantName,
                  style: AppTextStyles.bodyDescription,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            S.of(context).totalSoldLabel(item.totalSold),
            style: AppTextStyles.productName.copyWith(
              color: AppColors.goldRoyal,
            ),
          ),
        ],
      ),
    );
  }
}
