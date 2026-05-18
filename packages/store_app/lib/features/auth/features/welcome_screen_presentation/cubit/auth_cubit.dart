import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_anonymously_use_case.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  SignInWithFacebookUseCase signInWithFacebookUseCase;
  SignInAnonymouslyUseCase signInAnonymouslyUseCase;
  AuthCubit({
    required this.signInWithFacebookUseCase,
    required this.signInWithGoogleUseCase,
    required this.signInAnonymouslyUseCase,
  }) : super(AuthState.initial());

  Future<void> signInAnonymously() async {
    emit(AuthState.loading());
    final result = await signInAnonymouslyUseCase.call();
    result.fold(
      (serverFailure) =>
          emit(AuthState.failure(failureMessage: serverFailure.errorMessage)),
      (_) => emit(AuthState.success()),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthState.loading());
    final result = await signInWithGoogleUseCase.call();

    result.fold(
      (serverFailure) =>
          emit(AuthState.failure(failureMessage: serverFailure.errorMessage)),
      (_) => emit(AuthState.success()),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(AuthState.loading());
    final result = await signInWithFacebookUseCase.call();

    result.fold(
      (serverFailure) =>
          emit(AuthState.failure(failureMessage: serverFailure.errorMessage)),
      (_) => emit(AuthState.success()),
    );
  }
}
