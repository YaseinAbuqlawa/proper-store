import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/repo/addresses_repo.dart';

@lazySingleton
class GetAddressesUseCase {
  final AddressesRepo repo;

  GetAddressesUseCase({required this.repo});

  Future<Either<ServerFailure, List<AddressModel>>> call({
    required String customerId,
  }) =>
      repo.getAddresses(customerId: customerId);
}
