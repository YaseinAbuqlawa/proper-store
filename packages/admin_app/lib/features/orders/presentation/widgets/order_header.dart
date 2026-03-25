import 'package:flutter/material.dart';

import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_details_style.dart';
import 'order_status_pill_badge.dart';

class OrderHeader extends StatelessWidget {
  final OrderModel order;

  const OrderHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final date = order.createdAtDate;
    final dateStr =
        '${date.day} / ${date.month.toString().padLeft(2, '0')} / ${date.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                l.navOrders,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: orderDetailsStone400,
                ),
              ),
            ),
            const Icon(Icons.chevron_left, size: 14, color: orderDetailsStone400),
            Flexible(
              child: Text(
                order.id,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: orderDetailsGold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                order.id,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: orderDetailsStone900,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            OrderStatusPillBadge(status: order.status),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 14, color: orderDetailsStone400),
            const SizedBox(width: 4),
            Text(
              dateStr,
              style: const TextStyle(fontSize: 12, color: orderDetailsStone400),
            ),
          ],
        ),
      ],
    );
  }
}
