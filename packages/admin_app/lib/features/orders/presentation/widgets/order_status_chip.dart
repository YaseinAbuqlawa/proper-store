import 'package:flutter/material.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

class OrderStatusChip extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final (label, color) = switch (status) {
      OrderStatus.pending => (l.orderStatusPending, Colors.amber),
      OrderStatus.confirmed => (l.orderStatusConfirmed, Colors.blue),
      OrderStatus.shipped => (l.orderStatusShipped, Colors.orange),
      OrderStatus.delivered => (l.orderStatusDelivered, Colors.green),
      OrderStatus.cancelled => (l.orderStatusCancelled, Colors.red),
      OrderStatus.refunded => (l.orderStatusRefunded, Colors.blueGrey),
    };

    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
