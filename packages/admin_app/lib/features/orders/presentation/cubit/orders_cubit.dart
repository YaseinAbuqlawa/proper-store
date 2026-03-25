import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../domain/use_cases/get_orders_use_case.dart';
import '../../domain/use_cases/update_order_status_use_case.dart';
import 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  OrdersCubit({
    required this.getOrdersUseCase,
    required this.updateOrderStatusUseCase,
  }) : super(const OrdersState());

  Future<void> loadOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));
    final result = await getOrdersUseCase.call(
      statusFilter: state.activeFilter,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.failure,
          failureMessage: failure.code,
        ),
      ),
      (tuple) {
        final (orders, lastDoc) = tuple;
        emit(
          state.copyWith(
            status: OrdersStatus.loaded,
            orders: orders,
            hasMore: orders.length == 20,
            lastDoc: lastDoc,
            failureMessage: '',
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == OrdersStatus.loadingMore) return;

    emit(state.copyWith(status: OrdersStatus.loadingMore));
    final result = await getOrdersUseCase.call(
      startAfter: state.lastDoc,
      statusFilter: state.activeFilter,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.loaded,
          hasMore: false,
          failureMessage: failure.code,
        ),
      ),
      (tuple) {
        final (newOrders, lastDoc) = tuple;
        emit(
          state.copyWith(
            status: OrdersStatus.loaded,
            orders: [...state.orders, ...newOrders],
            hasMore: newOrders.length == 20,
            lastDoc: lastDoc,
            failureMessage: '',
          ),
        );
      },
    );
  }

  Future<void> filterByStatus(OrderStatus? status) async {
    emit(
      state.copyWith(
        activeFilter: status,
        orders: [],
        lastDoc: null,
        hasMore: true,
      ),
    );
    await loadOrders();
  }

  Future<void> updateStatus(String orderId, OrderStatus newStatus) async {
    final result = await updateOrderStatusUseCase.call(
      orderId: orderId,
      newStatus: newStatus,
    );

    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.code)),
      (_) {
        final updated = state.orders.map((o) {
          return o.id == orderId ? o.copyWith(status: newStatus) : o;
        }).toList();
        emit(state.copyWith(orders: updated, failureMessage: ''));
      },
    );
  }
}
