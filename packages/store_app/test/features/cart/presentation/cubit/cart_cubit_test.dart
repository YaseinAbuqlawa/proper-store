import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/cart/domain/use_cases/load_cart_items_use_case.dart';
import 'package:proper_store/features/cart/domain/use_cases/save_cart_items_use_case.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([LoadCartItemsUseCase, SaveCartItemsUseCase])
void main() {
  late MockLoadCartItemsUseCase mockLoad;
  late MockSaveCartItemsUseCase mockSave;

  final guestItem = CartItemModel(
    id: 'prod-1${const Color(0xFFFF0000).toARGB32()}',
    productId: 'prod-1',
    variantKey: 'ffff0000',
    name: 'Guest Product',
    selectedColor: const Color(0xFFFF0000),
    imageUrl: 'https://example.com/a.jpg',
    sellingPrice: 100.0,
    discountValue: 0.0,
    quantity: 2,
  );

  final savedItem = CartItemModel(
    id: 'prod-2${const Color(0xFF0000FF).toARGB32()}',
    productId: 'prod-2',
    variantKey: 'ff0000ff',
    name: 'Saved Product',
    selectedColor: const Color(0xFF0000FF),
    imageUrl: 'https://example.com/b.jpg',
    sellingPrice: 200.0,
    discountValue: 0.0,
    quantity: 1,
  );

  CartCubit buildCubit() => CartCubit(
    saveCartItems: mockSave,
    loadCartItems: mockLoad,
  );

  setUp(() {
    mockLoad = MockLoadCartItemsUseCase();
    mockSave = MockSaveCartItemsUseCase();
    provideDummy<Either<ServerFailure, void>>(const Right(null));
    provideDummy<Either<ServerFailure, List<CartItemModel>>>(const Right([]));
    when(
      mockSave.call(customerId: anyNamed('customerId'), items: anyNamed('items')),
    ).thenAnswer((_) async => const Right(null));
  });

  group('loadCart — pre-sign-in cart merge', () {
    blocTest<CartCubit, CartState>(
      'loads Firestore cart when no guest items exist',
      build: () {
        when(
          mockLoad.call(customerId: 'uid-1'),
        ).thenAnswer((_) async => Right([savedItem]));
        return buildCubit();
      },
      act: (cubit) => cubit.loadCart('uid-1'),
      expect: () => [
        isA<CartState>().having((s) => s.products, 'products', [savedItem]),
      ],
    );

    blocTest<CartCubit, CartState>(
      'preserves guest items and appends non-duplicate Firestore items',
      build: () {
        when(
          mockLoad.call(customerId: 'uid-1'),
        ).thenAnswer((_) async => Right([savedItem]));
        return buildCubit()..emit(CartState(
          cartState: CartStates.initial,
          products: [guestItem],
        ));
      },
      act: (cubit) => cubit.loadCart('uid-1'),
      expect: () => [
        isA<CartState>().having(
          (s) => s.products,
          'products',
          containsAll([guestItem, savedItem]),
        ),
      ],
      verify: (cubit) {
        // Merged cart must be synced back to Firestore
        final captured = verify(
          mockSave.call(
            customerId: 'uid-1',
            items: captureAnyNamed('items'),
          ),
        ).captured;
        final savedItems = captured.first as List<CartItemModel>;
        expect(savedItems, containsAll([guestItem, savedItem]));
      },
    );

    test('guest item takes priority when same id exists in Firestore cart', () async {
      // Saved version of guestItem has quantity 1 but guest version has 2
      final savedVersionOfGuestItem = guestItem.copyWith(quantity: 1);
      when(
        mockLoad.call(customerId: 'uid-1'),
      ).thenAnswer((_) async => Right([savedVersionOfGuestItem]));

      final cubit = buildCubit()..emit(CartState(
        cartState: CartStates.initial,
        products: [guestItem],
      ));
      await cubit.loadCart('uid-1');

      // Guest quantity (2) must win over saved quantity (1) — no duplicate
      expect(cubit.state.products.length, 1);
      expect(cubit.state.products.first.quantity, 2);

      await cubit.close();
    });

    blocTest<CartCubit, CartState>(
      'keeps guest items when Firestore load fails',
      build: () {
        when(
          mockLoad.call(customerId: 'uid-1'),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));
        return buildCubit()..emit(CartState(
          cartState: CartStates.initial,
          products: [guestItem],
        ));
      },
      act: (cubit) => cubit.loadCart('uid-1'),
      expect: () => [], // no state change — guest items remain untouched
      verify: (cubit) {
        expect(cubit.state.products, [guestItem]);
        // Guest items synced to Firestore under the new uid
        final captured = verify(
          mockSave.call(
            customerId: 'uid-1',
            items: captureAnyNamed('items'),
          ),
        ).captured;
        expect(captured.first, [guestItem]);
      },
    );
  });
}
