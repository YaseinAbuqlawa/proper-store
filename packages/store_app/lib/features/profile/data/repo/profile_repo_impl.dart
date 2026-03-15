import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store/features/profile/domain/repo/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<ServerFailure, CustomerModel>> getCustomerData({
    required String customerId,
  }) async {
    try {
      return Right(
        await remoteDataSource.getCustomerData(customerId: customerId),
      );
    } on FirebaseException catch (e) {
      return Left(ServerFailure(code: e.code));
    } catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
