part of 'product_form_cubit.dart';

@freezed
abstract class ProductFormState with _$ProductFormState {
  const factory ProductFormState.initial() = _Initial;
  const factory ProductFormState.submitting() = _Submitting;
  const factory ProductFormState.success() = _Success;
  const factory ProductFormState.failure(ServerFailure failure) = _Failure;
}
