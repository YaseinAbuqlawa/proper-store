import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/reports/domain/entities/dashboard_stats.dart';
import 'package:admin/features/reports/domain/entities/out_of_stock_product.dart';
import 'package:admin/features/reports/domain/repo/reports_repo.dart';
import 'package:admin/features/reports/domain/use_cases/get_out_of_stock_products_use_case.dart';

class _FakeReportsRepo implements ReportsRepo {
  final Either<ServerFailure, List<OutOfStockProduct>> oosResult;

  _FakeReportsRepo(this.oosResult);

  @override
  Future<Either<ServerFailure, DashboardStats>> getDashboardStats() async =>
      Left(const ServerFailure(code: 'not-called'));

  @override
  Future<Either<ServerFailure, List<OutOfStockProduct>>>
      getOutOfStockProducts() async => oosResult;
}

void main() {
  test('returns list on success', () async {
    final products = [
      const OutOfStockProduct(
        productId: 'p1',
        name: 'Bag A',
        outOfStockVariants: ['Red', 'Blue'],
      ),
    ];

    final useCase = GetOutOfStockProductsUseCase(
      repo: _FakeReportsRepo(Right(products)),
    );

    final result = await useCase();

    expect(result.isRight(), true);
    result.fold(
      (_) => fail('expected Right'),
      (list) => expect(list.first.productId, 'p1'),
    );
  });

  test('returns failure on error', () async {
    final useCase = GetOutOfStockProductsUseCase(
      repo: _FakeReportsRepo(
        Left(const ServerFailure(code: 'permission-denied')),
      ),
    );

    final result = await useCase();

    expect(result.isLeft(), true);
    result.fold(
      (f) => expect(f.code, 'permission-denied'),
      (_) => fail('expected Left'),
    );
  });
}
