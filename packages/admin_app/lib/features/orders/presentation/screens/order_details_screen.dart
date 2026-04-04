import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/orders/presentation/cubit/order_details_cubit.dart';
import 'package:admin/features/orders/presentation/cubit/order_details_state.dart';
import 'package:admin/features/orders/presentation/widgets/customer_card.dart';
import 'package:admin/features/orders/presentation/widgets/order_header.dart';
import 'package:admin/features/orders/presentation/widgets/order_summary_card.dart';
import 'package:admin/features/orders/presentation/widgets/products_card.dart';
import 'package:admin/features/orders/presentation/widgets/update_status_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrderDetailsCubit>()..init(order),
      child: const _OrderDetailsView(),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  const _OrderDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: const Color(0x14000000),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF57534E)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Proper Store',
          style: TextStyle(
            color: Color(0xFF1C1917),
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          final order = state.order;
          if (order == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrderHeader(order: order),
                const SizedBox(height: 16),
                UpdateStatusButton(
                  order: order,
                  isUpdating: state.isUpdatingStatus,
                ),
                if (state.failure != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    state.failure!.fromException(context: context),
                    style: const TextStyle(
                      color: AppColors.errorRed,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
                CustomerCard(state: state),
                const SizedBox(height: 16),
                ProductsCard(order: order),
                const SizedBox(height: 16),
                OrderSummaryCard(order: order),
              ],
            ),
          );
        },
      ),
    );
  }
}
