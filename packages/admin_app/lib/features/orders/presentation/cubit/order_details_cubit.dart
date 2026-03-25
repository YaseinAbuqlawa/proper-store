import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../domain/use_cases/get_customer_use_case.dart';
import '../../domain/use_cases/update_order_status_use_case.dart';
import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final GetCustomerUseCase getCustomerUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  OrderDetailsCubit({
    required this.getCustomerUseCase,
    required this.updateOrderStatusUseCase,
  }) : super(const OrderDetailsState());

  void init(OrderModel order) {
    emit(state.copyWith(order: order));
    _loadCustomer(order.customerId);
  }

  Future<void> _loadCustomer(String customerId) async {
    emit(state.copyWith(isLoadingCustomer: true));
    final result = await getCustomerUseCase.call(customerId: customerId);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingCustomer: false, failureMessage: failure.code),
      ),
      (customer) => emit(
        state.copyWith(
          isLoadingCustomer: false,
          customer: customer,
          failureMessage: '',
        ),
      ),
    );
  }

  Future<void> updateStatus(OrderStatus newStatus) async {
    final current = state.order;
    if (current == null) return;

    emit(state.copyWith(isUpdatingStatus: true, failureMessage: ''));
    final result = await updateOrderStatusUseCase.call(
      orderId: current.id,
      newStatus: newStatus,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isUpdatingStatus: false, failureMessage: failure.code),
      ),
      (_) => emit(
        state.copyWith(
          isUpdatingStatus: false,
          order: current.copyWith(status: newStatus),
          failureMessage: '',
        ),
      ),
    );
  }
}
