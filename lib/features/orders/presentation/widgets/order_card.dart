import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/features/orders/presentation/widgets/order_status_widgets.dart';
import 'package:proper_store/generated/l10n.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final date = order.createdAtDate;
    final dateStr = '${date.day}/${date.month}/${date.year}';
    final firstProduct = order.products.first;
    final extraCount = order.products.length - 1;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header: order number ↔ total ──────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Rightmost in RTL: order number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.orderNumberLabel,
                    style: AppTextStyles.bodyDescription,
                  ),
                  Text('#${order.id}', style: AppTextStyles.productName),
                ],
              ),
              // Leftmost in RTL: total
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(s.orderTotalLabel, style: AppTextStyles.bodyDescription),
                  Text(
                    '${order.grandTotal.toStringAsFixed(0)}${s.currencySymbol}',
                    style: AppTextStyles.priceNow,
                  ),
                ],
              ),
            ],
          ),

          const Divider(height: 20, thickness: 0.15),

          // ── First product preview ──────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rightmost in RTL: product image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  firstProduct.imageUrl,
                  width: 82,
                  height: 82,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 82,
                    height: 82,
                    color: AppColors.blackCard,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstProduct.name,
                      style: AppTextStyles.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s.quantityLabel(firstProduct.quantity),
                      style: AppTextStyles.bodyDescription,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${s.orderedOnLabel} $dateStr',
                      style: AppTextStyles.bodyDescription,
                    ),
                    if (extraCount > 0)
                      Text(
                        s.moreProductsLabel(extraCount),
                        style: AppTextStyles.bodyDescription.copyWith(
                          color: AppColors.goldMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Status section ─────────────────────────────────────────
          switch (order.status) {
            OrderStatus.delivered => OrderStatusBadge(
              label: s.orderStatusDelivered,
              color: AppColors.successGreen,
              icon: Icons.check_circle_outline,
            ),
            OrderStatus.cancelled => OrderStatusBadge(
              label: s.orderStatusCancelled,
              color: AppColors.errorRed,
              icon: Icons.cancel_outlined,
            ),
            _ => OrderStatusTracker(status: order.status, s: s),
          },

          const SizedBox(height: 14),

          // ── View details button ────────────────────────────────────
          OutlinedButton.icon(
            onPressed: () =>
                context.push(AppRoutes.orderDetails.path, extra: order),
            icon: const Icon(Icons.receipt_long_outlined, size: 18),
            label: Text(s.orderDetails),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.goldRoyal),
              foregroundColor: AppColors.goldRoyal,
              padding: const EdgeInsets.symmetric(vertical: 12),
              textStyle: AppTextStyles.bodyDescription.copyWith(
                color: AppColors.goldRoyal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
