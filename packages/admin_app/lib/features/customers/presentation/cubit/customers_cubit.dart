import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_customers_use_case.dart';
import 'customers_state.dart';

@injectable
class CustomersCubit extends Cubit<CustomersState> {
  final GetCustomersUseCase getCustomersUseCase;

  CustomersCubit({required this.getCustomersUseCase})
      : super(const CustomersState());

  Future<void> loadCustomers() async {
    emit(state.copyWith(status: CustomersStatus.loading));

    final result = await getCustomersUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomersStatus.failure,
          failureMessage: failure.code,
        ),
      ),
      (customers) => emit(
        state.copyWith(
          status: CustomersStatus.loaded,
          allCustomers: customers,
          filteredCustomers: customers,
          failureMessage: '',
        ),
      ),
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredCustomers: state.allCustomers));
      return;
    }

    final q = query.toLowerCase();
    final filtered = state.allCustomers.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.email.toLowerCase().contains(q);
    }).toList();

    emit(state.copyWith(filteredCustomers: filtered));
  }
}
