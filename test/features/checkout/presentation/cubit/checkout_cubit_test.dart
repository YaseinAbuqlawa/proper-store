import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/cart/data/models/cart_item_model.dart';
import 'package:proper_store/features/checkout/data/models/shipping_cost_model.dart';
import 'package:proper_store/features/checkout/domain/use_cases/get_shipping_cost_use_case.dart';
import 'package:proper_store/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart';

import 'checkout_cubit_test.mocks.dart';

@GenerateMocks([CreateOrderUseCase, GetShippingCostUseCase, FirebaseAuth, User])
void main() {
  late MockCreateOrderUseCase mockCreateOrderUseCase;
  late MockGetShippingCostUseCase mockGetShippingCostUseCase;
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
    quantity: 2,
  );

  CheckoutCubit buildCubit() => CheckoutCubit(
    createOrderUseCase: mockCreateOrderUseCase,
    getShippingCostUseCase: mockGetShippingCostUseCase,
    auth: mockFirebaseAuth,
  );

  setUp(() {
    mockCreateOrderUseCase = MockCreateOrderUseCase();
    mockGetShippingCostUseCase = MockGetShippingCostUseCase();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    when(mockUser.uid).thenReturn(testUid);
    when(mockUser.isAnonymous).thenReturn(false);
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    provideDummy<Either<ServerFailure, String>>(const Right(''));
    provideDummy<Either<ServerFailure, ShippingCostModel>>(
      Right(const ShippingCostModel(areaCosts: {})),
    );
  });

  group('initial state', () {
    test('is CheckoutState.initial', () {
      expect(buildCubit().state, const CheckoutState.initial());
    });
  });

  group('loadShippingCost', () {
    test('populates shipping model on success', () async {
      final model = ShippingCostModel(areaCosts: {'القاهرة': 50.0});
      when(
        mockGetShippingCostUseCase.call(),
      ).thenAnswer((_) async => Right(model));
      final cubit = buildCubit();
      await cubit.loadShippingCost();
      expect(cubit.shippingCostFor('القاهرة'), 50.0);
    });

    blocTest<CheckoutCubit, CheckoutState>(
      'emits failure when use case returns error',
      build: () {
        when(
          mockGetShippingCostUseCase.call(),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));
        return buildCubit();
      },
      act: (cubit) => cubit.loadShippingCost(),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.maybeWhen(
            failure: (msg) => msg.isNotEmpty,
            orElse: () => false,
          ),
          'has failure message',
          isTrue,
        ),
      ],
    );
  });

  group('shippingCostFor', () {
    test('returns cost for known city', () async {
      when(mockGetShippingCostUseCase.call()).thenAnswer(
        (_) async => Right(
          ShippingCostModel(areaCosts: {'القاهرة': 50.0, 'الإسكندرية': 70.0}),
        ),
      );
      final cubit = buildCubit();
      await cubit.loadShippingCost();
      expect(cubit.shippingCostFor('القاهرة'), 50.0);
      expect(cubit.shippingCostFor('الإسكندرية'), 70.0);
    });

    test('returns null for unknown city', () async {
      when(mockGetShippingCostUseCase.call()).thenAnswer(
        (_) async => Right(ShippingCostModel(areaCosts: {'القاهرة': 50.0})),
      );
      final cubit = buildCubit();
      await cubit.loadShippingCost();
      expect(cubit.shippingCostFor('أسوان'), isNull);
    });

    test('returns null before loadShippingCost is called', () {
      expect(buildCubit().shippingCostFor('القاهرة'), isNull);
    });
  });

  group('placeOrder', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits [placing, success] with generated orderId on success',
      build: () {
        when(mockCreateOrderUseCase.call(order: anyNamed('order'))).thenAnswer((
          invocation,
        ) async {
          final order = invocation.namedArguments[const Symbol('order')];
          return Right(order.id as String);
        });
        return buildCubit();
      },
      act: (cubit) => cubit.placeOrder(
        products: [testCartItem],
        shippingAddress: testAddress,
        shippingCost: 50.0,
      ),
      expect: () => [
        const CheckoutState.placing(),
        isA<CheckoutState>().having(
          (s) => s.maybeWhen(
            success: (id) => id.startsWith('ORD-'),
            orElse: () => false,
          ),
          'orderId starts with ORD-',
          isTrue,
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits [placing, failure] on use case error',
      build: () {
        when(
          mockCreateOrderUseCase.call(order: anyNamed('order')),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'internal')));
        return buildCubit();
      },
      act: (cubit) => cubit.placeOrder(
        products: [testCartItem],
        shippingAddress: testAddress,
        shippingCost: 0.0,
      ),
      expect: () => [
        const CheckoutState.placing(),
        isA<CheckoutState>().having(
          (s) => s.maybeWhen(
            failure: (msg) => msg.isNotEmpty,
            orElse: () => false,
          ),
          'has failure message',
          isTrue,
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'order includes shippingCost and correct totals',
      build: () {
        when(mockCreateOrderUseCase.call(order: anyNamed('order'))).thenAnswer((
          invocation,
        ) async {
          final order = invocation.namedArguments[const Symbol('order')];
          // sellingPrice=100, discountValue=10, quantity=2
          // totalPrice=200, discountTotal=20, netTotal=180, shippingCost=50
          expect(order.totalPrice, 200.0);
          expect(order.discountTotal, 20.0);
          expect(order.netTotal, 180.0);
          expect(order.shippingCost, 50.0);
          return Right(order.id as String);
        });
        return buildCubit();
      },
      act: (cubit) => cubit.placeOrder(
        products: [testCartItem],
        shippingAddress: testAddress,
        shippingCost: 50.0,
      ),
      expect: () => [const CheckoutState.placing(), isA<CheckoutState>()],
    );
  });
}
