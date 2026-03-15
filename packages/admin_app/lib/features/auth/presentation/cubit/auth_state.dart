part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required StaffModel user}) =
      _Authenticated;
  const factory AuthState.failure({required String failureMessage}) = _Failure;
}
