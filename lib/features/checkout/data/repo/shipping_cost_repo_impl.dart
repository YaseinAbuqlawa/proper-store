import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/checkout/data/data_sources/shipping_cost_remote_data_source.dart';
import 'package:proper_store/features/checkout/data/models/shipping_cost_model.dart';
import 'package:proper_store/features/checkout/domain/repo/shipping_cost_repo.dart';

@LazySingleton(as: ShippingCostRepo)
class ShippingCostRepoImpl implements ShippingCostRepo {
  final ShippingCostRemoteDataSource remoteDataSource;

  ShippingCostRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, ShippingCostModel>> getShippingCost() async {
    try {
      return Right(await remoteDataSource.getShippingCost());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
