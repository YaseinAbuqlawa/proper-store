import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/addresses/data/data_sources/addresses_remote_data_source.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/repo/addresses_repo.dart';

@LazySingleton(as: AddressesRepo)
class AddressesRepoImpl implements AddressesRepo {
  final AddressesRemoteDataSource remoteDataSource;

  AddressesRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<AddressModel>>> getAddresses({
    required String customerId,
  }) async {
    try {
      return Right(
        await remoteDataSource.getAddresses(customerId: customerId),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> addAddress({
    required String customerId,
    required AddressModel address,
  }) async {
    try {
      return Right(
        await remoteDataSource.addAddress(
          customerId: customerId,
          address: address,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteAddress({
    required String customerId,
    required AddressModel address,
  }) async {
    try {
      return Right(
        await remoteDataSource.deleteAddress(
          customerId: customerId,
          address: address,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
