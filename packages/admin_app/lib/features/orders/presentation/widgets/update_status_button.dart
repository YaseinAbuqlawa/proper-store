import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../cubit/order_details_cubit.dart';
import 'order_details_style.dart';
import 'order_status_utils.dart';
import 'status_bottom_sheet.dart';

class UpdateStatusButton extends StatelessWidget {
  final OrderModel order;
  final bool isUpdating;

  const UpdateStatusButton({
    super.key,
    required this.order,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    if (validNextStatuses(order.status).isEmpty) return const SizedBox.shrink();
    final l = S.of(context);
    return Container(
      decoration: orderDetailsCardDecoration(),
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: isUpdating ? null : () => _showSheet(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: orderDetailsStone900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isUpdating
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l.updateStatusLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.change_circle_outlined,
                        color: Colors.white, size: 20),
                  ],
                ),
        ),
      ),
    );
  }

  void _showSheet(BuildContext context) {
    final cubit = context.read<OrderDetailsCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => StatusBottomSheet(
        currentStatus: order.status,
        onStatusSelected: (s) {
          Navigator.pop(context);
          if (s != order.status) cubit.updateStatus(s);
        },
      ),
    );
  }
}
