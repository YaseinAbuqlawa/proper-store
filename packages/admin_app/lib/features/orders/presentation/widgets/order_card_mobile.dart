import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_status_chip.dart';

class OrderCardMobile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onView;

  const OrderCardMobile({
    super.key,
    required this.order,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final date = order.createdAtDate;
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l.orderNumberLabel}: ${order.id}',
                    style: AppTextStyles.sectionTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  OrderStatusChip(status: order.status),
                  const SizedBox(height: 6),
                  Text(
                    '${l.orderTotalLabel}: ${order.grandTotal.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
                    style: AppTextStyles.bodyDescription,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${l.orderDateLabel}: $dateStr',
                    style: AppTextStyles.bodyDescription,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: onView,
              tooltip: l.orderDetails,
            ),
          ],
        ),
      ),
    );
  }
}
