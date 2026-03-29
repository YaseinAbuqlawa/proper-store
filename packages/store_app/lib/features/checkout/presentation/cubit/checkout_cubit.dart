import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/shipping_cost_model.dart';
import 'package:proper_store/features/checkout/domain/use_cases/get_shipping_cost_use_case.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart';

part 'checkout_cubit.freezed.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateOrderUseCase createOrderUseCase;
  final GetShippingCostUseCase getShippingCostUseCase;
  final FirebaseAuth auth;

  ShippingCostModel? _shippingCostModel;

  CheckoutCubit({
    required this.createOrderUseCase,
    required this.getShippingCostUseCase,
    required this.auth,
  }) : super(const CheckoutState.initial());

  Future<void> loadShippingCost() async {
    final result = await getShippingCostUseCase.call();
    result.fold(
      (failure) =>
          emit(CheckoutState.failure(failureMessage: failure.errorMessage)),
      (model) => _shippingCostModel = model,
    );
  }

  /// Returns the shipping cost for [city], or null if the city is not
  /// configured or the shipping model has not been loaded yet.
  double? shippingCostFor(String city) => _shippingCostModel?.costForCity(city);

  Future<void> placeOrder({
    required List<CartItemModel> products,
    required AddressModel shippingAddress,
    required double shippingCost,
  }) async {
    emit(const CheckoutState.placing());

    final order = OrderModel(
      id: _generateOrderId(),
      customerId: auth.currentUser!.uid,
      products: products,
      totalPrice: products.totalPriceBeforeDiscount,
      discountTotal: products.totalDiscount,
      netTotal: products.totalPriceAfterDiscount,
      shippingCost: shippingCost,
      shippingAddress: shippingAddress,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    final result = await createOrderUseCase.call(order: order);
    result.fold(
      (failure) {
        if (failure is OutOfStockFailure) {
          emit(CheckoutState.outOfStock(
            productName: failure.productName,
            variantName: failure.variantName,
            available: failure.available,
          ));
        } else {
          emit(CheckoutState.failure(failureMessage: failure.code));
        }
      },
      (orderId) => emit(CheckoutState.success(orderId: orderId)),
    );
  }

  String _generateOrderId() {
    final now = DateTime.now();
    final date =
        '${now.year.toString().substring(2)}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final suffix = List.generate(
      4,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
    return 'ORD-$date-$suffix';
  }
}
