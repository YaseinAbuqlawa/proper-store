import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart';
import 'package:proper_store/features/orders/domain/use_cases/get_customer_orders_use_case.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_state.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([
  GetCustomerOrdersUseCase,
  CreateOrderUseCase,
  FirebaseAuth,
  User,
])
void main() {
  late MockGetCustomerOrdersUseCase mockGetOrdersUseCase;
  late MockCreateOrderUseCase mockCreateOrderUseCase;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  const testUid = 'test-uid-123';

  final testAddress = AddressModel(
    id: 'addr-1',
    label: 'Home',
    fullName: 'Test User',
    phone: '01012345678',
    city: 'القاهرة',
    area: 'المعادي',
    street: 'Street 9',
    buildingNumber: '5',
    floor: '3',
    apartment: '12',
  );

  final testCartItem = CartItemModel(
    id: 'item-1',
    productId: 'prod-1',
    name: 'Test Product',
    selectedColor: const Color(0xFFFFFFFF),
    imageUrl: 'https://example.com/image.jpg',
    sellingPrice: 100.0,
    discountValue: 10.0,
    quantity: 1,
  );

  final testOrder = OrderModel(
    id: 'order-1',
    customerId: testUid,
    products: [testCartItem],
    totalPrice: 100.0,
    discountTotal: 10.0,
    netTotal: 90.0,
    shippingAddress: testAddress,
  );

  OrdersCubit buildCubit() => OrdersCubit(
    getCustomerOrdersUseCase: mockGetOrdersUseCase,
    createOrderUseCase: mockCreateOrderUseCase,
    auth: mockFirebaseAuth,
  );

  setUp(() {
    mockGetOrdersUseCase = MockGetCustomerOrdersUseCase();
    mockCreateOrderUseCase = MockCreateOrderUseCase();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    when(mockUser.uid).thenReturn(testUid);
    when(mockUser.isAnonymous).thenReturn(false);
    provideDummy<Either<ServerFailure, List<OrderModel>>>(Right([]));
    provideDummy<Either<ServerFailure, String>>(const Right(''));
  });

  // ── getCustomerOrders ────────────────────────────────────────────────────────

  group('getCustomerOrders', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits loaded([]) when currentUser is null',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        return buildCubit();
      },
      act: (cubit) => cubit.getCustomerOrders(),
      expect: () => [const OrdersState.loaded(orders: [])],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits loaded([]) when user is anonymous',
      build: () {
        when(mockUser.isAnonymous).thenReturn(true);
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        return buildCubit();
      },
      act: (cubit) => cubit.getCustomerOrders(),
      expect: () => [const OrdersState.loaded(orders: [])],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, loaded] on success',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockGetOrdersUseCase.call(customerId: testUid),
        ).thenAnswer((_) async => Right([testOrder]));
        return buildCubit();
      },
      act: (cubit) => cubit.getCustomerOrders(),
      expect: () => [
        const OrdersState.loading(),
        OrdersState.loaded(orders: [testOrder]),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, failure] on error',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockGetOrdersUseCase.call(customerId: testUid),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));
        return buildCubit();
      },
      act: (cubit) => cubit.getCustomerOrders(),
      expect: () => [
        const OrdersState.loading(),
        isA<OrdersState>().having(
          (s) => s.maybeWhen(failure: (msg) => msg, orElse: () => null),
          'failureMessage',
          isNotNull,
        ),
      ],
    );
  });

  // ── addOrder ─────────────────────────────────────────────────────────────────

  group('addOrder', () {
    test('returns order ID and prepends to list on success', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(
        mockCreateOrderUseCase.call(order: testOrder),
      ).thenAnswer((_) async => const Right('new-order-id'));

      final cubit = buildCubit()..emit(OrdersState.loaded(orders: []));

      final result = await cubit.addOrder(order: testOrder);

      expect(result, 'new-order-id');
      cubit.state.whenOrNull(
        loaded: (orders) => expect(orders.first.id, 'new-order-id'),
      );

      await cubit.close();
    });

    test('returns null and emits failure on error', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(
        mockCreateOrderUseCase.call(order: testOrder),
      ).thenAnswer((_) async => Left(ServerFailure(code: 'internal')));

      final cubit = buildCubit();
      final result = await cubit.addOrder(order: testOrder);

      expect(result, isNull);
      expect(
        cubit.state.maybeWhen(failure: (_) => true, orElse: () => false),
        true,
      );

      await cubit.close();
    });
  });
}
