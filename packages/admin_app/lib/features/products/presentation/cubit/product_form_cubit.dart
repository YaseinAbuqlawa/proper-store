import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/params/product_save_params.dart';
import '../../domain/use_cases/save_product_use_case.dart';

part 'product_form_cubit.freezed.dart';
part 'product_form_state.dart';

@injectable
class ProductFormCubit extends Cubit<ProductFormState> {
  final SaveProductUseCase saveProductUseCase;

  ProductFormCubit({required this.saveProductUseCase})
    : super(const ProductFormState.initial());

  Future<void> submit(ProductSaveParams params) async {
    emit(const ProductFormState.submitting());
    final result = await saveProductUseCase.call(params);
    result.fold(
      (failure) => emit(ProductFormState.failure(failure.code)),
      (_) => emit(const ProductFormState.success()),
    );
  }
}
