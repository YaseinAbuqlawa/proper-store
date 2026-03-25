import 'package:flutter/material.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_details_style.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderModel order;

  const OrderSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    return Container(
      decoration: orderDetailsCardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.orderAccountSummaryLabel,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
              color: orderDetailsStone400,
            ),
          ),
          const SizedBox(height: 20),
          _SummaryRow(
            label: l.subtotalLabel,
            value:
                '${order.totalPrice.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
          ),
          const SizedBox(height: 12),
          if (order.discountTotal > 0) ...[
            _SummaryRow(
              label: l.discountAmountLabel,
              value:
                  '-${order.discountTotal.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
              valueColor: AppColors.successGreen,
            ),
            const SizedBox(height: 12),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.shippingLabel,
                style: const TextStyle(
                    fontSize: 13, color: orderDetailsStone600),
              ),
              order.shippingCost == 0
                  ? Text(
                      l.freeShippingLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: orderDetailsGold,
                      ),
                    )
                  : Text(
                      '${order.shippingCost.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
                      style: const TextStyle(
                          fontSize: 13, color: orderDetailsStone600),
                    ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: orderDetailsStone100),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.grandTotalLabel,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: orderDetailsStone900,
                ),
              ),
              Text(
                '${order.grandTotal.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: orderDetailsGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: orderDetailsStone600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: valueColor ?? orderDetailsStone600,
            fontWeight:
                valueColor != null ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
