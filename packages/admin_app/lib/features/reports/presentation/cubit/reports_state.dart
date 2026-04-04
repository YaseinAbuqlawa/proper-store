part of 'reports_cubit.dart';

@freezed
abstract class ReportsState with _$ReportsState {
  const factory ReportsState.reportsInitial() = _ReportsInitial;
  const factory ReportsState.reportsLoading() = _ReportsLoading;
  const factory ReportsState.reportsLoaded({
    required DashboardStats stats,
    required List<OutOfStockProduct> outOfStockProducts,
    required bool isLoadingOos,
    String? oosFailure,
  }) = _ReportsLoaded;
  const factory ReportsState.reportsFailure(String message) = _ReportsFailure;
}
