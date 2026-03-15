import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/app_failures.dart';
import '../repo/products_repo.dart';

@lazySingleton
class DeleteProductUseCase {
  final ProductsRepo repo;

  const DeleteProductUseCase({required this.repo});

  Future<Either<ServerFailure, void>> call(String id) =>
      repo.deleteProduct(id: id);
}
