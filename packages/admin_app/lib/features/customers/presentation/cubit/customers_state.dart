import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store_shared/failures/app_failures.dart';
import 'package:proper_store_shared/models/customer_model.dart';

part 'customers_state.freezed.dart';

enum CustomersStatus { initial, loading, loaded, failure }

@freezed
abstract class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default(CustomersStatus.initial) CustomersStatus status,
    @Default([]) List<CustomerModel> allCustomers,
    @Default([]) List<CustomerModel> filteredCustomers,
    ServerFailure? failure,
  }) = _CustomersState;
}
