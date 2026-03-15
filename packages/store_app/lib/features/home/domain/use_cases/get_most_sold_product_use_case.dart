import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/features/home/domain/repo/home_repo.dart';

@lazySingleton
class GetMostSoldProductUseCase {
  final HomeRepo repo;
  GetMostSoldProductUseCase({required this.repo});

  Future<Either<ServerFailure, List<ProductModel>>> call() async {
    return await repo.getMostSoldProducts();
  }
}
