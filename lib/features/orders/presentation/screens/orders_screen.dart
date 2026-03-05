import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/app_snackbar.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_state.dart';
import 'package:proper_store/features/orders/presentation/widgets/order_card.dart';
import 'package:proper_store/generated/l10n.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getCustomerOrders();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.ordersTitle)),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (message) {
              if (!context.mounted) return;
              AppSnackbar.errorSnackbar(
                context: context,
                failureMessage: message,
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (orders) => orders.isEmpty
                ? _EmptyOrders(s: s)
                : _OrdersList(orders: orders),
            failure: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: AppTextStyles.bodyDescription,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<OrdersCubit>().getCustomerOrders(),
                    child: const Text(
                      'إعادة المحاولة',
                    ), // أو ممكن تستخدم S.of(context).retry لو ضايفها
                  ),
                ],
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  final S s;
  const _EmptyOrders({required this.s});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty_orders.json',
            width: 220,
            repeat: true,
          ),
          AppSpacing.verticalSpaceSmall,
          Text(s.noOrdersYet, style: AppTextStyles.productName),
          AppSpacing.verticalSpaceSmall,
          Text(
            s.noOrdersYetMessage,
            style: AppTextStyles.bodyDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  const _OrdersList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppSpacing.screenPadding,
      itemCount: orders.length,
      separatorBuilder: (_, _) => AppSpacing.verticalSpaceSmall,
      itemBuilder: (_, index) => OrderCard(order: orders[index]),
    );
  }
}
