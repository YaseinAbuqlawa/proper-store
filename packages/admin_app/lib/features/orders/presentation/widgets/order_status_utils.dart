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
    };

(Color, Color) orderStatusColors(OrderStatus status) => switch (status) {
      OrderStatus.pending => (AppColors.statusPendingBg, AppColors.statusPendingFg),
      OrderStatus.confirmed => (AppColors.statusConfirmedBg, AppColors.statusConfirmedFg),
      OrderStatus.shipped => (AppColors.statusShippedBg, AppColors.statusShippedFg),
      OrderStatus.delivered => (AppColors.statusDeliveredBg, AppColors.statusDeliveredFg),
      OrderStatus.cancelled => (AppColors.statusCancelledBg, AppColors.statusCancelledFg),
    };
