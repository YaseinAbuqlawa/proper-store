part of 'staff_cubit.dart';

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
}
