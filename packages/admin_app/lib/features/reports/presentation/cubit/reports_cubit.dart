import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/failures/app_failures.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/out_of_stock_product.dart';
import '../../domain/use_cases/get_dashboard_stats_use_case.dart';
import '../../domain/use_cases/get_out_of_stock_products_use_case.dart';

part 'reports_cubit.freezed.dart';
part 'reports_state.dart';

@injectable
class ReportsCubit extends Cubit<ReportsState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;
  final GetOutOfStockProductsUseCase getOutOfStockProductsUseCase;

  ReportsCubit({
    required this.getDashboardStatsUseCase,
    required this.getOutOfStockProductsUseCase,
  }) : super(const ReportsState.reportsInitial());

  Future<void> loadDashboard() async {
    // Capture existing OOS data so a refresh never silently discards it.
    final previous = state.mapOrNull(reportsLoaded: (s) => s);

    emit(const ReportsState.reportsLoading());
    final result = await getDashboardStatsUseCase();
    result.fold(
      (failure) => emit(ReportsState.reportsFailure(failure)),
      (stats) => emit(
        ReportsState.reportsLoaded(
          stats: stats,
          outOfStockProducts: previous?.outOfStockProducts ?? const [],
          isLoadingOos: previous?.isLoadingOos ?? false,
          oosFailure: previous?.oosFailure,
        ),
      ),
    );
  }

  Future<void> loadOutOfStockProducts() async {
    final current = state.mapOrNull(reportsLoaded: (s) => s);
    if (current == null) return;

    emit(
      ReportsState.reportsLoaded(
        stats: current.stats,
        outOfStockProducts: current.outOfStockProducts,
        isLoadingOos: true,
        oosFailure: null,
      ),
    );

    final result = await getOutOfStockProductsUseCase();
    result.fold(
      (failure) => emit(
        ReportsState.reportsLoaded(
          stats: current.stats,
          outOfStockProducts: const [],
          isLoadingOos: false,
          oosFailure: failure.code,
        ),
      ),
      (products) => emit(
        ReportsState.reportsLoaded(
          stats: current.stats,
          outOfStockProducts: products,
          isLoadingOos: false,
        ),
      ),
    );
  }
}
