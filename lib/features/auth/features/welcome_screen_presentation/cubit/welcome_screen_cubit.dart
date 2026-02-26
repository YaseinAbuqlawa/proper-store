import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_anonymously_use_case.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';

part 'welcome_screen_cubit.freezed.dart';
part 'welcome_screen_state.dart';

@injectable
class WelcomeScreenCubit extends Cubit<WelcomeScreenState> {
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  SignInWithFacebookUseCase signInWithFacebookUseCase;
  SignInAnonymouslyUseCase signInAnonymouslyUseCase;
  WelcomeScreenCubit({
    required this.signInWithFacebookUseCase,
    required this.signInWithGoogleUseCase,
    required this.signInAnonymouslyUseCase,
  }) : super(WelcomeScreenState.initial());

  Future<void> signInAnonymously() async {
    await signInAnonymouslyUseCase.call();
  }

  Future<void> signInWithGoogle() async {
    emit(WelcomeScreenState.loading());
    final result = await signInWithGoogleUseCase.call();

    result.fold(
      (serverFailure) => emit(
        WelcomeScreenState.failure(failureMessage: serverFailure.errorMessage),
      ),
      (_) => emit(WelcomeScreenState.success()),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(WelcomeScreenState.loading());
    final result = await signInWithFacebookUseCase.call();

    result.fold(
      (serverFailure) => emit(
        WelcomeScreenState.failure(failureMessage: serverFailure.errorMessage),
      ),
      (_) => emit(WelcomeScreenState.success()),
    );
  }
}
