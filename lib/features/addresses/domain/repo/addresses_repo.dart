import 'package:fpdart/fpdart.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';

abstract class AddressesRepo {
  Future<Either<ServerFailure, List<AddressModel>>> getAddresses({
    required String customerId,
  });

  Future<Either<ServerFailure, void>> addAddress({
    required String customerId,
    required AddressModel address,
  });

  Future<Either<ServerFailure, void>> deleteAddress({
    required String customerId,
    required AddressModel address,
  });
}
