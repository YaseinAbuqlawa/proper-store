import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/orders/data/models/order_model.dart';
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart';
import 'package:proper_store/features/orders/domain/use_cases/get_customer_orders_use_case.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_state.dart';

@lazySingleton
class OrdersCubit extends Cubit<OrdersState> {
  final GetCustomerOrdersUseCase getCustomerOrdersUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final FirebaseAuth auth;

  OrdersCubit({
    required this.getCustomerOrdersUseCase,
    required this.createOrderUseCase,
    required this.auth,
  }) : super(const OrdersState.initial());

  Future<void> getCustomerOrders() async {
    final user = auth.currentUser;
    if (user == null || user.isAnonymous) {
      emit(const OrdersState.loaded(orders: []));
      return;
    }

    emit(const OrdersState.loading());
    final result = await getCustomerOrdersUseCase.call(customerId: user.uid);
    result.fold(
      (failure) =>
          emit(OrdersState.failure(failureMessage: failure.errorMessage)),
      (orders) => emit(OrdersState.loaded(orders: orders)),
    );
  }

  Future<String?> addOrder({required OrderModel order}) async {
    final result = await createOrderUseCase.call(order: order);
    return result.fold(
      (failure) {
        emit(OrdersState.failure(failureMessage: failure.errorMessage));
        return null;
      },
      (orderId) {
        state.whenOrNull(
          loaded: (orders) => emit(
            OrdersState.loaded(
              orders: [
                order.copyWith(id: orderId),
                ...orders,
              ],
            ),
          ),
        );
        return orderId;
      },
    );
  }
}
