import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/features/home/data/models/category_model.dart';
import 'package:proper_store/features/home/domain/repo/home_repo.dart';

@lazySingleton
class GetBagCategoriesUseCase {
  final HomeRepo repo;
  GetBagCategoriesUseCase({required this.repo});

  Future<Either<ServerFailure, List<CategoryModel>>> call() async {
    return await repo.getBagCategories();
  }
}
