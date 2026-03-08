import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/generated/l10n.dart';

// ── Status badge (delivered / cancelled) ──────────────────────────────────────

class OrderStatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const OrderStatusBadge({
    super.key,
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
        mainAxisAlignment: MainAxisAlignment.center,
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

class OrderStatusTracker extends StatelessWidget {
  final OrderStatus status;
  final S s;

  const OrderStatusTracker({super.key, required this.status, required this.s});

  int get _activeStep => switch (status) {
    OrderStatus.pending || OrderStatus.confirmed => 0,
    OrderStatus.shipped => 1,
    OrderStatus.delivered => 2,
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
      child: Icon(isCompleted ? Icons.check : icon, size: 18, color: iconColor),
    );
  }
}
