part of 'addresses_cubit.dart';

@freezed
abstract class AddressesState with _$AddressesState {
  const factory AddressesState.initial() = _Initial;
  const factory AddressesState.loading() = _Loading;
  const factory AddressesState.loaded({required List<AddressModel> addresses}) =
      _Loaded;
  const factory AddressesState.failure({required String failureMessage}) =
      _Failure;
}
