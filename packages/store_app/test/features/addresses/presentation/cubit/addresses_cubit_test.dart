import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/use_cases/add_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/delete_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/get_addresses_use_case.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';

import 'addresses_cubit_test.mocks.dart';

@GenerateMocks([
  GetAddressesUseCase,
  AddAddressUseCase,
  DeleteAddressUseCase,
  FirebaseAuth,
  User,
])
void main() {
  late MockGetAddressesUseCase mockGetAddressesUseCase;
  late MockAddAddressUseCase mockAddAddressUseCase;
  late MockDeleteAddressUseCase mockDeleteAddressUseCase;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  const testUid = 'test-uid-123';
  final testAddress = AddressModel(
    id: '1',
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

  AddressesCubit buildCubit() => AddressesCubit(
        getAddressesUseCase: mockGetAddressesUseCase,
        addAddressUseCase: mockAddAddressUseCase,
        deleteAddressUseCase: mockDeleteAddressUseCase,
        auth: mockFirebaseAuth,
      );

  setUp(() {
    mockGetAddressesUseCase = MockGetAddressesUseCase();
    mockAddAddressUseCase = MockAddAddressUseCase();
    mockDeleteAddressUseCase = MockDeleteAddressUseCase();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    when(mockUser.uid).thenReturn(testUid);
    when(mockUser.isAnonymous).thenReturn(false);
    // Mockito cannot infer dummy values for Either<> generics — provide them explicitly.
    provideDummy<Either<ServerFailure, List<AddressModel>>>(Right([]));
    provideDummy<Either<ServerFailure, void>>(Right(null));
  });

  group('getAddresses', () {
    blocTest<AddressesCubit, AddressesState>(
      'emits nothing when currentUser is null',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        return buildCubit();
      },
      act: (cubit) => cubit.getAddresses(),
      expect: () => [],
    );

    blocTest<AddressesCubit, AddressesState>(
      'emits nothing when user is anonymous',
      build: () {
        when(mockUser.isAnonymous).thenReturn(true);
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        return buildCubit();
      },
      act: (cubit) => cubit.getAddresses(),
      expect: () => [],
    );

    blocTest<AddressesCubit, AddressesState>(
      'emits [loading, loaded] on success',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockGetAddressesUseCase.call(customerId: testUid))
            .thenAnswer((_) async => Right([testAddress]));
        return buildCubit();
      },
      act: (cubit) => cubit.getAddresses(),
      expect: () => [
        const AddressesState.loading(),
        AddressesState.loaded(addresses: [testAddress]),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'emits [loading, failure] on error',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockGetAddressesUseCase.call(customerId: testUid))
            .thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));
        return buildCubit();
      },
      act: (cubit) => cubit.getAddresses(),
      expect: () => [
        const AddressesState.loading(),
        isA<AddressesState>().having(
          (s) => s.maybeWhen(failure: (msg) => msg, orElse: () => null),
          'failureMessage',
          isNotNull,
        ),
      ],
    );
  });

  group('addAddress', () {
    blocTest<AddressesCubit, AddressesState>(
      'emits nothing when currentUser is null',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        return buildCubit();
      },
      act: (cubit) => cubit.addAddress(testAddress),
      expect: () => [],
    );

    blocTest<AddressesCubit, AddressesState>(
      'falls back to getAddresses when previous state is not loaded',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockAddAddressUseCase.call(
            customerId: testUid,
            address: testAddress,
          ),
        ).thenAnswer((_) async => Right<ServerFailure, void>(null));
        when(mockGetAddressesUseCase.call(customerId: testUid))
            .thenAnswer((_) async => Right([testAddress]));
        return buildCubit();
      },
      act: (cubit) => cubit.addAddress(testAddress),
      wait: const Duration(milliseconds: 50),
      // Cubit deduplicates equal consecutive states: the second emit(loading)
      // inside getAddresses() is skipped because state is already loading.
      expect: () => [
        const AddressesState.loading(),
        AddressesState.loaded(addresses: [testAddress]),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'appends non-default address to list without touching existing addresses',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockAddAddressUseCase.call(
            customerId: testUid,
            address: testAddress,
          ),
        ).thenAnswer((_) async => Right<ServerFailure, void>(null));
        return buildCubit();
      },
      seed: () => AddressesState.loaded(addresses: const []),
      act: (cubit) => cubit.addAddress(testAddress),
      expect: () => [
        const AddressesState.loading(),
        AddressesState.loaded(addresses: [testAddress]),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'resets all existing addresses to isDefault:false when new address is default',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        final newDefault = testAddress.copyWith(id: '2', isDefault: true);
        when(
          mockAddAddressUseCase.call(
            customerId: testUid,
            address: newDefault,
          ),
        ).thenAnswer((_) async => Right<ServerFailure, void>(null));
        return buildCubit();
      },
      seed: () => AddressesState.loaded(
        addresses: [testAddress.copyWith(isDefault: true)],
      ),
      act: (cubit) {
        final newDefault = testAddress.copyWith(id: '2', isDefault: true);
        return cubit.addAddress(newDefault);
      },
      expect: () {
        final newDefault = testAddress.copyWith(id: '2', isDefault: true);
        return [
          const AddressesState.loading(),
          AddressesState.loaded(
            addresses: [
              testAddress.copyWith(isDefault: false),
              newDefault,
            ],
          ),
        ];
      },
    );

    blocTest<AddressesCubit, AddressesState>(
      'emits [loading, failure] on error',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockAddAddressUseCase.call(
            customerId: testUid,
            address: testAddress,
          ),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'internal')));
        return buildCubit();
      },
      act: (cubit) => cubit.addAddress(testAddress),
      expect: () => [
        const AddressesState.loading(),
        isA<AddressesState>().having(
          (s) => s.maybeWhen(failure: (msg) => msg, orElse: () => null),
          'failureMessage',
          isNotNull,
        ),
      ],
    );
  });

  group('deleteAddress', () {
    blocTest<AddressesCubit, AddressesState>(
      'emits nothing when currentUser is null',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        return buildCubit();
      },
      act: (cubit) => cubit.deleteAddress(testAddress),
      expect: () => [],
    );

    blocTest<AddressesCubit, AddressesState>(
      'removes address from list locally without emitting loading',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockDeleteAddressUseCase.call(
            customerId: testUid,
            address: testAddress,
          ),
        ).thenAnswer((_) async => Right<ServerFailure, void>(null));
        return buildCubit();
      },
      seed: () => AddressesState.loaded(addresses: [testAddress]),
      act: (cubit) => cubit.deleteAddress(testAddress),
      expect: () => [
        AddressesState.loaded(addresses: const []),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'emits failure state on error',
      build: () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(
          mockDeleteAddressUseCase.call(
            customerId: testUid,
            address: testAddress,
          ),
        ).thenAnswer((_) async => Left(ServerFailure(code: 'permission-denied')));
        return buildCubit();
      },
      seed: () => AddressesState.loaded(addresses: [testAddress]),
      act: (cubit) => cubit.deleteAddress(testAddress),
      expect: () => [
        isA<AddressesState>().having(
          (s) => s.maybeWhen(failure: (msg) => msg, orElse: () => null),
          'failureMessage',
          isNotNull,
        ),
      ],
    );
  });
}
