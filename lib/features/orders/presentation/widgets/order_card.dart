import 'package:flutter/material.dart';

import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
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
                  Text(
                    '#${order.id.substring(0, 6).toUpperCase()}',
                    style: AppTextStyles.productName,
                  ),
                ],
              ),
              // Leftmost in RTL: total
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    s.orderTotalLabel,
                    style: AppTextStyles.bodyDescription,
                  ),
                  Text(
                    '${order.netTotal.toStringAsFixed(0)}${s.currencySymbol}',
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
                      'الكمية: ${firstProduct.quantity}',
                      style: AppTextStyles.bodyDescription,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${s.orderedOnLabel} $dateStr',
                      style: AppTextStyles.bodyDescription,
                    ),
                    if (extraCount > 0)
                      Text(
                        '+$extraCount منتجات أخرى',
                        style: AppTextStyles.bodyDescription
                            .copyWith(color: AppColors.goldMuted),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Status section ─────────────────────────────────────────
          switch (order.status) {
            OrderStatus.delivered => _StatusBadge(
                label: s.orderStatusDelivered,
                color: AppColors.successGreen,
                icon: Icons.check_circle_outline,
              ),
            OrderStatus.cancelled => _StatusBadge(
                label: s.orderStatusCancelled,
                color: AppColors.errorRed,
                icon: Icons.cancel_outlined,
              ),
            _ => _StatusTracker(status: order.status, s: s),
          },

          const SizedBox(height: 14),

          // ── View details button ────────────────────────────────────
          OutlinedButton.icon(
            onPressed: () {
              // TODO(Step-10): Navigate to order details screen
            },
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

// ── Status badge (delivered / cancelled) ──────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _StatusBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.bodyDescription.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 3-step tracker (pending / confirmed / shipped) ────────────────────────────

class _StatusTracker extends StatelessWidget {
  final OrderStatus status;
  final S s;

  const _StatusTracker({required this.status, required this.s});

  int get _activeStep => switch (status) {
        OrderStatus.pending || OrderStatus.confirmed => 0,
        OrderStatus.shipped => 1,
        _ => 0,
      };

  @override
  Widget build(BuildContext context) {
    final activeStep = _activeStep;

    final steps = [
      (label: s.orderStepPreparing, icon: Icons.inventory_2_outlined),
      (label: s.orderStepShipping, icon: Icons.local_shipping_outlined),
      (label: s.orderStepDelivery, icon: Icons.home_outlined),
    ];

    return Column(
      children: [
        // Step circles + connecting lines
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              _StepCircle(
                icon: steps[i].icon,
                stepIndex: i,
                activeStep: activeStep,
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: i < activeStep
                        ? AppColors.goldRoyal
                        : AppColors.textSecondary.withValues(alpha: 0.25),
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        // Step labels
        Row(
          children: [
            for (int i = 0; i < steps.length; i++)
              Expanded(
                child: Text(
                  steps[i].label,
                  textAlign: i == 0
                      ? TextAlign.start
                      : i == steps.length - 1
                          ? TextAlign.end
                          : TextAlign.center,
                  style: AppTextStyles.bodyDescription.copyWith(
                    fontSize: 11,
                    color: i == activeStep
                        ? AppColors.goldRoyal
                        : AppColors.textSecondary,
                    fontWeight: i == activeStep
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  final IconData icon;
  final int stepIndex;
  final int activeStep;

  const _StepCircle({
    required this.icon,
    required this.stepIndex,
    required this.activeStep,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = stepIndex < activeStep;
    final isActive = stepIndex == activeStep;

    final Color bgColor;
    final Color iconColor;
    final Color borderColor;

    if (isActive) {
      bgColor = AppColors.goldRoyal;
      iconColor = AppColors.blackDeep;
      borderColor = AppColors.goldRoyal;
    } else if (isCompleted) {
      bgColor = AppColors.blackCard;
      iconColor = AppColors.goldMuted;
      borderColor = AppColors.goldMuted;
    } else {
      bgColor = AppColors.blackCard;
      iconColor = AppColors.textSecondary;
      borderColor = AppColors.textSecondary.withValues(alpha: 0.3);
    }

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Icon(
        isCompleted ? Icons.check : icon,
        size: 18,
        color: iconColor,
      ),
    );
  }
}
