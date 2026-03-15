import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/add_category_use_case.dart';
import '../../domain/use_cases/get_categories_use_case.dart';

part 'categories_cubit.freezed.dart';
part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.addCategoryUseCase,
  }) : super(const CategoriesState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    final result = await getCategoriesUseCase.call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          failureMessage: failure.code,
          status: CategoriesStatus.failure,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: categories,
          status: CategoriesStatus.success,
        ),
      ),
    );
  }

  Future<void> addCategory(String name, Uint8List imageBytes) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    final result = await addCategoryUseCase.call(
      name: name,
      imageBytes: imageBytes,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          failureMessage: failure.code,
          status: CategoriesStatus.failure,
        ),
      ),
      (_) => emit(state.copyWith(status: CategoriesStatus.success)),
    );
  }
}
