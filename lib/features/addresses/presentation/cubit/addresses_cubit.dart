import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/domain/use_cases/add_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/delete_address_use_case.dart';
import 'package:proper_store/features/addresses/domain/use_cases/get_addresses_use_case.dart';

part 'addresses_cubit.freezed.dart';
part 'addresses_state.dart';

@lazySingleton
class AddressesCubit extends Cubit<AddressesState> {
  final GetAddressesUseCase getAddressesUseCase;
  final AddAddressUseCase addAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final FirebaseAuth auth;

  AddressesCubit({
    required this.getAddressesUseCase,
    required this.addAddressUseCase,
    required this.deleteAddressUseCase,
    required this.auth,
  }) : super(AddressesState.initial());

  Future<void> getAddresses() async {
    final user = auth.currentUser;
    if (user == null || user.isAnonymous) return;

    emit(const AddressesState.loading());
    final result = await getAddressesUseCase.call(customerId: user.uid);
    result.fold(
      (failure) =>
          emit(AddressesState.failure(failureMessage: failure.errorMessage)),
      (addresses) => emit(AddressesState.loaded(addresses: addresses)),
    );
  }

  Future<void> addAddress(AddressModel address) async {
    final user = auth.currentUser;
    if (user == null || user.isAnonymous) return;

    final previousState = state; // Capture before overwriting with loading.
    emit(const AddressesState.loading());
    final result = await addAddressUseCase.call(
      customerId: user.uid,
      address: address,
    );

    result.fold(
      (failure) =>
          emit(AddressesState.failure(failureMessage: failure.errorMessage)),
      (_) {
        previousState.maybeWhen(
          loaded: (currentAddresses) {
            List<AddressModel> updatedList;

            if (address.isDefault) {
              updatedList =
                  currentAddresses
                      .map((a) => a.copyWith(isDefault: false))
                      .toList()
                    ..add(address);
            } else {
              updatedList = List<AddressModel>.from(currentAddresses)
                ..add(address);
            }

            emit(AddressesState.loaded(addresses: updatedList));
          },
          orElse: () => getAddresses(),
        );
      },
    );
  }

  Future<void> deleteAddress(AddressModel address) async {
    final user = auth.currentUser;
    if (user == null || user.isAnonymous) return;

    final result = await deleteAddressUseCase.call(
      customerId: user.uid,
      address: address,
    );

    result.fold(
      (failure) =>
          emit(AddressesState.failure(failureMessage: failure.errorMessage)),
      (_) {
        state.maybeWhen(
          loaded: (currentAddresses) {
            final updatedList = currentAddresses
                .where((a) => a.id != address.id)
                .toList();
            emit(AddressesState.loaded(addresses: updatedList));
          },
          orElse: () => getAddresses(),
        );
      },
    );
  }
}
