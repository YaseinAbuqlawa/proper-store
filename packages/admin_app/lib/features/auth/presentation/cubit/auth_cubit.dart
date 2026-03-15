import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/helpers/app_consts.dart';
import 'package:admin/features/auth/domain/entities/staff_user.dart';
import 'package:admin/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:admin/features/auth/domain/use_cases/sign_out_use_case.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({required this.signInUseCase, required this.signOutUseCase})
    : super(const AuthState.initial());

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthState.loading());
    final result = await signInUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(
        AuthState.failure(
          failureMessage: failure is FirebaseFailure
              ? failure.code
              : AppConsts.unexpectedErrorText,
        ),
      ),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> signOut() async {
    await signOutUseCase();
    emit(const AuthState.initial());
  }
}
