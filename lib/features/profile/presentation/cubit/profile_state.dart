part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded({required CustomerModel customer}) =
      _Loaded;
  const factory ProfileState.anonymous() = _Anonymous;
  const factory ProfileState.failure({required String failureMessage}) =
      _Failure;
}
