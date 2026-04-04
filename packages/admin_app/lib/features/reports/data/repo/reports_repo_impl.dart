import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/failures/app_failures.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/out_of_stock_product.dart';
import '../../domain/repo/reports_repo.dart';
import '../data_sources/reports_remote_data_source.dart';

@LazySingleton(as: ReportsRepo)
class ReportsRepoImpl implements ReportsRepo {
  final ReportsRemoteDataSource dataSource;

  const ReportsRepoImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, DashboardStats>> getDashboardStats() async {
    try {
      final model = await dataSource.getDashboardStats();
      return Right(model.toEntity());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (_) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }

  @override
  Future<Either<ServerFailure, List<OutOfStockProduct>>>
  getOutOfStockProducts() async {
    try {
      final models = await dataSource.getOutOfStockProducts();
      return Right(models.map((m) => m.toEntity()).toList());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(code: e.code));
    } catch (_) {
      return Left(const ServerFailure(code: AppConsts.unexpectedErrorText));
    }
  }
}
