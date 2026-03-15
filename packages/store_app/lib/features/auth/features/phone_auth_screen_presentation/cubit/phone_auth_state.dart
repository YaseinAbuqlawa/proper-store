part of 'phone_auth_cubit.dart';

@freezed
abstract class PhoneAuthState with _$PhoneAuthState {
  const factory PhoneAuthState.initial() = _Initial;
  const factory PhoneAuthState.phoneLoading() = _PhoneLoading;
  const factory PhoneAuthState.otpLoading() = _OtpLoading;
  const factory PhoneAuthState.otpSent() = _OtpSent;
  const factory PhoneAuthState.otpIssue({required String failureMessage}) =
      _OtpIssue;
  const factory PhoneAuthState.otpVerified() = _OtpVerified;
  const factory PhoneAuthState.phoneIssue({required String failureMessage}) =
      _PhoneIssue;
}
