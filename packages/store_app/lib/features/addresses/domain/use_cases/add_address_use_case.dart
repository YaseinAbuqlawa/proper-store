import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/repo/addresses_repo.dart';

@lazySingleton
class AddAddressUseCase {
  final AddressesRepo repo;

  AddAddressUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call({
    required String customerId,
    required AddressModel address,
  }) =>
      repo.addAddress(customerId: customerId, address: address);
}
