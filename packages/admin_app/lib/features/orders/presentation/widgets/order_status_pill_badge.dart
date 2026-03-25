import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_status_utils.dart';

class OrderStatusPillBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusPillBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = orderStatusColors(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
      ),
      child: Text(
        orderStatusLabel(S.of(context), status),
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
