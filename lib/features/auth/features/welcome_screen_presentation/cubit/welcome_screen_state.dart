part of 'welcome_screen_cubit.dart';

@freezed
class WelcomeScreenState with _$WelcomeScreenState {
  const factory WelcomeScreenState.initial() = _Initial;
  const factory WelcomeScreenState.loading() = _Loading;
  const factory WelcomeScreenState.success() = _Success;
  const factory WelcomeScreenState.failure({required String failureMessage}) =
      _Failure;
}
