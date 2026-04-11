import 'package:flutter/material.dart';

import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_details_style.dart';
import 'order_status_utils.dart';

class StatusBottomSheet extends StatelessWidget {
  final OrderStatus currentStatus;
  final ValueChanged<OrderStatus> onStatusSelected;

  const StatusBottomSheet({
    super.key,
    required this.currentStatus,
    required this.onStatusSelected,
  });

  static ({IconData icon, Color iconBg, Color iconColor}) _styleFor(
    OrderStatus status,
  ) => switch (status) {
    OrderStatus.confirmed => (
      icon: Icons.sync,
      iconBg: const Color(0xFFEFF6FF),
      iconColor: const Color(0xFF2563EB),
    ),
    OrderStatus.shipped => (
      icon: Icons.local_shipping_outlined,
      iconBg: const Color(0xFFFFFBEB),
      iconColor: const Color(0xFFD97706),
    ),
    OrderStatus.delivered => (
      icon: Icons.check_circle_outline,
      iconBg: const Color(0xFFECFDF5),
      iconColor: const Color(0xFF059669),
    ),
    OrderStatus.cancelled => (
      icon: Icons.cancel_outlined,
      iconBg: const Color(0xFFFEF2F2),
      iconColor: const Color(0xFFDC2626),
    ),
    OrderStatus.refunded => (
      icon: Icons.currency_exchange,
      iconBg: const Color(0xFFF5F3FF),
      iconColor: const Color(0xFF7C3AED),
    ),
    OrderStatus.pending => (
      icon: Icons.hourglass_empty,
      iconBg: const Color(0xFFFFF7ED),
      iconColor: const Color(0xFFEA580C),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final nextStatuses = validNextStatuses(currentStatus);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 6,
            margin: const EdgeInsets.only(top: 16, bottom: 8),
            decoration: BoxDecoration(
              color: orderDetailsStone100,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
            child: Column(
              children: [
                Text(
                  l.updateStatusLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: orderDetailsStone900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.selectNewStatusHint,
                  style: const TextStyle(
                      fontSize: 12, color: orderDetailsStone400),
                ),
              ],
            ),
          ),
          const Divider(height: 24, color: orderDetailsStone100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: nextStatuses.map((status) {
                final style = _styleFor(status);
                return _StatusOption(
                  label: orderStatusLabel(l, status),
                  iconBg: style.iconBg,
                  iconColor: style.iconColor,
                  icon: style.icon,
                  isSelected: false,
                  onTap: () => onStatusSelected(status),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: orderDetailsStone50,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: orderDetailsStone900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l.cancelLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  final String label;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusOption({
    required this.label,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? iconColor : iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? iconColor : orderDetailsStone900,
                ),
              ),
            ),
            const Icon(Icons.chevron_left,
                color: orderDetailsStone400, size: 20),
          ],
        ),
      ),
    );
  }
}
