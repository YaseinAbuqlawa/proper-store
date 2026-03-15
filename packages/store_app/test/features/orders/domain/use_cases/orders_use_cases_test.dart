import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/order_model.dart';
import 'package:proper_store/features/orders/domain/repo/orders_repo.dart';
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart';
import 'package:proper_store/features/orders/domain/use_cases/get_customer_orders_use_case.dart';

import 'orders_use_cases_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late MockOrdersRepo mockRepo;

  const testUid = 'user-123';

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

  setUp(() {
    mockRepo = MockOrdersRepo();
    provideDummy<Either<ServerFailure, List<OrderModel>>>(Right([]));
    provideDummy<Either<ServerFailure, String>>(const Right(''));
  });

  group('GetCustomerOrdersUseCase', () {
    late GetCustomerOrdersUseCase useCase;

    setUp(() => useCase = GetCustomerOrdersUseCase(repo: mockRepo));

    test('returns order list on success', () async {
      when(mockRepo.getCustomerOrders(customerId: testUid))
          .thenAnswer((_) async => Right([testOrder]));

      final result = await useCase.call(customerId: testUid);

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (orders) => expect(orders, [testOrder]),
      );
      verify(mockRepo.getCustomerOrders(customerId: testUid)).called(1);
    });

    test('returns failure on error', () async {
      when(mockRepo.getCustomerOrders(customerId: testUid))
          .thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));

      final result = await useCase.call(customerId: testUid);

      expect(result.isLeft(), true);
    });
  });

  group('CreateOrderUseCase', () {
    late CreateOrderUseCase useCase;

    setUp(() => useCase = CreateOrderUseCase(repo: mockRepo));

    test('returns order ID on success', () async {
      when(mockRepo.createOrder(order: testOrder))
          .thenAnswer((_) async => const Right('new-order-id'));

      final result = await useCase.call(order: testOrder);

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (id) => expect(id, 'new-order-id'),
      );
      verify(mockRepo.createOrder(order: testOrder)).called(1);
    });

    test('returns failure on error', () async {
      when(mockRepo.createOrder(order: testOrder))
          .thenAnswer((_) async => Left(ServerFailure(code: 'permission-denied')));

      final result = await useCase.call(order: testOrder);

      expect(result.isLeft(), true);
    });
  });
}
