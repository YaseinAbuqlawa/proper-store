import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_phone_number_use_case.dart';

part 'phone_auth_cubit.freezed.dart';
part 'phone_auth_state.dart';

@injectable
class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;

  PhoneAuthCubit({required this.signInWithPhoneNumberUseCase})
    : super(PhoneAuthState.initial());

  Future<void> signInWithPhone(String phoneNumber) async {
    emit(PhoneAuthState.phoneLoading());
    final result = await signInWithPhoneNumberUseCase.sendOtp(
      phoneNumber: phoneNumber,
    );

    result.fold(
      (serverFailure) => emit(
        PhoneAuthState.phoneIssue(failureMessage: serverFailure.errorMessage),
      ),
      (_) => emit(PhoneAuthState.otpSent()),
    );
  }

  Future<void> verifyOtp(String code) async {
    emit(PhoneAuthState.otpLoading());
    final result = await signInWithPhoneNumberUseCase.verifyOtp(code: code);

    result.fold(
      (serverFailure) => emit(
        PhoneAuthState.otpIssue(failureMessage: serverFailure.errorMessage),
      ),
      (_) => emit(PhoneAuthState.otpVerified()),
    );
  }

  void backToInitialState() {
    emit(PhoneAuthState.initial());
  }
}
