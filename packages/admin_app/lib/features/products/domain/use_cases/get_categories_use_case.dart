import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/products_repo.dart';

@lazySingleton
class GetCategoriesUseCase {
  final ProductsRepo repo;

  const GetCategoriesUseCase({required this.repo});

  Future<Either<ServerFailure, List<String>>> call() => repo.getCategories();
}
