import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/repo/addresses_repo.dart';
import 'package:proper_store/features/addresses/domain/use_cases/add_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/delete_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/get_addresses_use_case.dart';

import 'addresses_use_cases_test.mocks.dart';

@GenerateMocks([AddressesRepo])
void main() {
  late MockAddressesRepo mockRepo;

  const testUid = 'user-123';
  const testAddress = AddressModel(
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

  setUp(() {
    mockRepo = MockAddressesRepo();
    provideDummy<Either<ServerFailure, List<AddressModel>>>(Right([]));
    provideDummy<Either<ServerFailure, void>>(Right(null));
  });

  group('GetAddressesUseCase', () {
    late GetAddressesUseCase useCase;

    setUp(() => useCase = GetAddressesUseCase(repo: mockRepo));

    test('returns address list on success', () async {
      when(mockRepo.getAddresses(customerId: testUid))
          .thenAnswer((_) async => Right([testAddress]));

      final result = await useCase.call(customerId: testUid);

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (addresses) => expect(addresses, [testAddress]),
      );
      verify(mockRepo.getAddresses(customerId: testUid)).called(1);
    });

    test('returns failure on error', () async {
      when(mockRepo.getAddresses(customerId: testUid))
          .thenAnswer((_) async => Left(ServerFailure(code: 'unavailable')));

      final result = await useCase.call(customerId: testUid);

      expect(result.isLeft(), true);
      verifyNever(mockRepo.addAddress(customerId: anyNamed('customerId'), address: anyNamed('address')));
    });
  });

  group('AddAddressUseCase', () {
    late AddAddressUseCase useCase;

    setUp(() => useCase = AddAddressUseCase(repo: mockRepo));

    test('delegates to repo.addAddress and returns Right on success', () async {
      when(mockRepo.addAddress(customerId: testUid, address: testAddress))
          .thenAnswer((_) async => Right(null));

      final result = await useCase.call(customerId: testUid, address: testAddress);

      expect(result.isRight(), true);
      verify(mockRepo.addAddress(customerId: testUid, address: testAddress)).called(1);
    });

    test('returns failure on error', () async {
      when(mockRepo.addAddress(customerId: testUid, address: testAddress))
          .thenAnswer((_) async => Left(ServerFailure(code: 'permission-denied')));

      final result = await useCase.call(customerId: testUid, address: testAddress);

      expect(result.isLeft(), true);
    });
  });

  group('DeleteAddressUseCase', () {
    late DeleteAddressUseCase useCase;

    setUp(() => useCase = DeleteAddressUseCase(repo: mockRepo));

    test('delegates to repo.deleteAddress and returns Right on success', () async {
      when(mockRepo.deleteAddress(customerId: testUid, address: testAddress))
          .thenAnswer((_) async => Right(null));

      final result = await useCase.call(customerId: testUid, address: testAddress);

      expect(result.isRight(), true);
      verify(mockRepo.deleteAddress(customerId: testUid, address: testAddress)).called(1);
    });

    test('returns failure on error', () async {
      when(mockRepo.deleteAddress(customerId: testUid, address: testAddress))
          .thenAnswer((_) async => Left(ServerFailure(code: 'not-found')));

      final result = await useCase.call(customerId: testUid, address: testAddress);

      expect(result.isLeft(), true);
    });
  });
}
