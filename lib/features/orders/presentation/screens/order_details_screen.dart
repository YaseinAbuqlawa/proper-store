import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store/features/cart/data/models/cart_item_model.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/features/orders/presentation/widgets/order_status_widgets.dart';
import 'package:proper_store/generated/l10n.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final date = order.createdAtDate;
    final dateStr =
        '${date.day}/${date.month}/${date.year}  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(s.orderDetailsTitle),
            Text(
              '#${order.id}',
              textDirection: TextDirection.ltr,
              style: AppTextStyles.bodyDescription.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // ── Status ────────────────────────────────────────────────
          _SectionHeader(title: s.orderStatusTitle),
          const SizedBox(height: 12),
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

          const SizedBox(height: 28),

          // ── Products list ──────────────────────────────────────────
          _SectionHeader(title: s.orderSummaryTitle),
          const SizedBox(height: 12),
          ...order.products.map((item) => _ProductRow(item: item, s: s)),

          const SizedBox(height: 28),

          // ── Price breakdown ────────────────────────────────────────
          _PriceBreakdown(order: order, s: s),

          const SizedBox(height: 28),

          // ── Shipping address ───────────────────────────────────────
          _SectionHeader(title: s.shippingAddressTitle),
          const SizedBox(height: 12),
          _AddressCard(order: order),

          const SizedBox(height: 28),

          // ── Payment method ─────────────────────────────────────────
          _SectionHeader(title: s.paymentMethodTitle),
          const SizedBox(height: 12),
          _InfoCard(icon: Icons.payments_outlined, text: s.paymentCOD),

          const SizedBox(height: 28),

          // ── Date placed ────────────────────────────────────────────
          _InfoCard(
            icon: Icons.calendar_today_outlined,
            text: '${s.orderedOnLabel} $dateStr',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SectionTitle(title: title);
  }
}

// ── Single product row ────────────────────────────────────────────────────────

class _ProductRow extends StatelessWidget {
  final CartItemModel item;
  final S s;

  const _ProductRow({required this.item, required this.s});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: Theme.of(context).cardColor,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  s.quantityLabel(item.quantity),
                  style: AppTextStyles.bodyDescription,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(item.offerPrice * item.quantity).toStringAsFixed(0)}${s.currencySymbol}',
            style: AppTextStyles.priceNow.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ── Price breakdown ────────────────────────────────────────────────────────────

class _PriceBreakdown extends StatelessWidget {
  final OrderModel order;
  final S s;

  const _PriceBreakdown({required this.order, required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Column(
        children: [
          _PriceRow(label: s.subtotalLabel, value: order.totalPrice, s: s),
          if (order.discountTotal > 0)
            _PriceRow(
              label: s.discountAmountLabel,
              value: -order.discountTotal,
              s: s,
              valueColor: AppColors.successGreen,
            ),
          _PriceRow(
            label: s.shippingLabel,
            value: order.shippingCost,
            s: s,
            valueColor: order.shippingCost == 0 ? AppColors.successGreen : null,
            overrideText: order.shippingCost == 0 ? s.shippingFree : null,
          ),
          const Divider(height: 20, thickness: 0.15),
          _PriceRow(
            label: s.grandTotalLabel,
            value: order.grandTotal,
            s: s,
            labelStyle: AppTextStyles.productName,
            valueStyle: AppTextStyles.priceNow,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final S s;
  final Color? valueColor;
  final String? overrideText;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _PriceRow({
    required this.label,
    required this.value,
    required this.s,
    this.valueColor,
    this.overrideText,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValueStyle = (valueStyle ?? AppTextStyles.bodyDescription)
        .copyWith(color: valueColor);

    final valueText =
        overrideText ??
        '${value < 0 ? '-' : ''}${value.abs().toStringAsFixed(0)}${s.currencySymbol}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle ?? AppTextStyles.bodyDescription),
          Text(valueText, style: effectiveValueStyle),
        ],
      ),
    );
  }
}

// ── Address card ───────────────────────────────────────────────────────────────

class _AddressCard extends StatelessWidget {
  final OrderModel order;
  const _AddressCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final addr = order.shippingAddress;
    final lines = [
      addr.fullName,
      addr.phone,
      '${addr.street}، ${addr.buildingNumber}',
      if (addr.floor.isNotEmpty || addr.apartment.isNotEmpty)
        'دور ${addr.floor}، شقة ${addr.apartment}',
      '${addr.area}، ${addr.city}',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(line, style: AppTextStyles.bodyDescription),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ── Generic info card (icon + text) ───────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.bodyDescription)),
        ],
      ),
    );
  }
}
