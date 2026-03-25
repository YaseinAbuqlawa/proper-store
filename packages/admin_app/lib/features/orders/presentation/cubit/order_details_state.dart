import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

part 'order_details_state.freezed.dart';

@freezed
abstract class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    OrderModel? order,
    CustomerModel? customer,
    @Default(false) bool isLoadingCustomer,
    @Default(false) bool isUpdatingStatus,
    @Default('') String failureMessage,
  }) = _OrderDetailsState;
}
