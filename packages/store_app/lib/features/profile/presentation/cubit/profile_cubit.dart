import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store/features/profile/domain/use_cases/get_customer_data_use_case.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final GetCustomerDataUseCase getCustomerDataUseCase;
  final SignOutUseCase signOutUseCase;
  final FirebaseAuth _auth;

  ProfileCubit({
    required this.getCustomerDataUseCase,
    required this.signOutUseCase,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(ProfileState.initial());

  Future<void> signOut() async {
    emit(ProfileState.loading());

    final result = await signOutUseCase.call();

    result.fold(
      (serverFailure) => emit(
        ProfileState.failure(failureMessage: serverFailure.errorMessage),
      ),
      (_) => null,
    );
  }

  Future<void> getCustomerData() async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) {
      return emit(ProfileState.anonymous());
    }

    emit(ProfileState.loading());
    final customerUid = user.uid;

    final result = await getCustomerDataUseCase.call(customerId: customerUid);

    result.fold(
      (serverFailure) => emit(
        ProfileState.failure(failureMessage: serverFailure.errorMessage),
      ),
      (customer) => emit(ProfileState.loaded(customer: customer)),
    );
  }

  void clearProfileData() {
    emit(ProfileState.initial());
  }
}
