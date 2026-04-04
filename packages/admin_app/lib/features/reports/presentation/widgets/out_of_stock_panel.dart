import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../../domain/entities/out_of_stock_product.dart';

/// Renders the lazy-loaded out-of-stock product list.
///
/// The list is not fetched automatically — the user taps a button to trigger
/// [onRequestOos]. The same callback is used for the initial load and retry
/// after a failure, keeping the caller's API simple.
class OutOfStockPanel extends StatelessWidget {
  final List<OutOfStockProduct> products;
  final bool isLoading;
  final String? failure;

  /// Invoked when the user taps "Load" or "Retry".
  /// The actual cubit call lives in the screen — this widget only receives
  /// the callback, never accessing the cubit directly.
  final VoidCallback onRequestOos;

  const OutOfStockPanel({
    super.key,
    required this.products,
    required this.isLoading,
    required this.onRequestOos,
    this.failure,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (failure != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.loadOutOfStockError, style: AppTextStyles.bodyDescription),
          const SizedBox(height: AppSpacing.small),
          FilledButton.icon(
            onPressed: onRequestOos,
            icon: const Icon(Icons.refresh_outlined),
            label: Text(l.retryBtn),
          ),
        ],
      );
    }

    if (products.isEmpty) {
      return FilledButton.icon(
        onPressed: onRequestOos,
        icon: const Icon(Icons.download_outlined),
        label: Text(l.loadOutOfStockBtn),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.outOfStockLabel, style: AppTextStyles.productName),
        const SizedBox(height: AppSpacing.medium),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            children: [
              for (int i = 0; i < products.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                _OosProductRow(product: products[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// Thumbnail size for the OOS product image — matches the top-selling row.
const double _kThumbnailSize = 40;

class _OosProductRow extends StatelessWidget {
  final OutOfStockProduct product;

  const _OosProductRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: product.mainImageUrl ?? '',
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
                  product.name,
                  style: AppTextStyles.bodyDescription.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: AppSpacing.small,
                  runSpacing: 4,
                  children: product.outOfStockVariants.map((v) {
                    return Chip(
                      label: Text(v, style: AppTextStyles.navLabel),
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
