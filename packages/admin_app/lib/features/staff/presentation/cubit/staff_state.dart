part of 'staff_cubit.dart';

enum StaffMutationSuccessType { roleChanged, passwordChanged, deleted }

@freezed
abstract class StaffState with _$StaffState {
  const factory StaffState.initial() = _Initial;
  const factory StaffState.loading() = _Loading;
  const factory StaffState.loaded({required List<StaffListItem> items}) =
      _Loaded;

  /// Fatal load failure — replaces the list.
  const factory StaffState.failure(ServerFailure failure) = _Failure;

  /// Mutation failure — list is still available; UI shows a snackbar.
  const factory StaffState.mutationFailure({
    required ServerFailure failure,
    required List<StaffListItem> items,
  }) = _MutationFailure;

  /// Mutation success — list is still available; UI shows a success snackbar.
  const factory StaffState.mutationSuccess({
    required StaffMutationSuccessType type,
    required List<StaffListItem> items,
  }) = _MutationSuccess;
}
