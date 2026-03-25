import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/customers/data/data_sources/customers_remote_data_source.dart';
import 'package:admin/features/customers/domain/repo/customers_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/customer_model.dart';

@LazySingleton(as: CustomersRepo)
class CustomersRepoImpl implements CustomersRepo {
  final CustomersRemoteDataSource dataSource;

  const CustomersRepoImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, List<CustomerModel>>> getCustomers() async {
    try {
      return Right(await dataSource.getCustomers());
    } on Exception catch (e) {
      return Left(ServerFailure(code: e.toString()));
    }
  }
}
