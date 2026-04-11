import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

String orderStatusLabel(S l, OrderStatus status) => switch (status) {
  OrderStatus.pending => l.orderStatusPending,
  OrderStatus.confirmed => l.orderStatusConfirmed,
  OrderStatus.shipped => l.orderStatusShipped,
  OrderStatus.delivered => l.orderStatusDelivered,
  OrderStatus.cancelled => l.orderStatusCancelled,
  OrderStatus.refunded => l.orderStatusRefunded,
};

List<OrderStatus> validNextStatuses(OrderStatus current) => switch (current) {
  OrderStatus.pending => [OrderStatus.confirmed, OrderStatus.cancelled],
  OrderStatus.confirmed => [OrderStatus.shipped, OrderStatus.cancelled],
  OrderStatus.shipped => [OrderStatus.delivered, OrderStatus.refunded],
  OrderStatus.delivered => [OrderStatus.refunded],
  OrderStatus.cancelled => [],
  OrderStatus.refunded => [],
};

(Color, Color) orderStatusColors(OrderStatus status) => switch (status) {
  OrderStatus.pending => (AppColors.statusPendingBg, AppColors.statusPendingFg),
  OrderStatus.confirmed => (
    AppColors.statusConfirmedBg,
    AppColors.statusConfirmedFg,
  ),
  OrderStatus.shipped => (AppColors.statusShippedBg, AppColors.statusShippedFg),
  OrderStatus.delivered => (
    AppColors.statusDeliveredBg,
    AppColors.statusDeliveredFg,
  ),
  OrderStatus.cancelled => (
    AppColors.statusCancelledBg,
    AppColors.statusCancelledFg,
  ),
  OrderStatus.refunded => (
    AppColors.statusRefundedBg,
    AppColors.statusRefundedFg,
  ),
};
