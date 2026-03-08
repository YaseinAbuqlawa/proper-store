import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/products/domain/use_cases/get_all_products_use_case.dart';
import 'package:proper_store/core/products/domain/use_cases/get_products_by_category_use_case.dart';

part 'products_screen_cubit.freezed.dart';
part 'products_screen_state.dart';

@injectable
class ProductsScreenCubit extends Cubit<ProductsScreenState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductFilter? _lastFilter;

  ProductsScreenCubit({
    required this.getAllProductsUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(const ProductsScreenState.initial());

  Future<void> loadProducts(ProductFilter filter) async {
    _lastFilter = filter;
    emit(const ProductsScreenState.loading());
    final result = switch (filter) {
      ProductFilterAll() => await getAllProductsUseCase(),
      ProductFilterByCategory(:final category) =>
        await getProductsByCategoryUseCase(category),
    };
    result.fold(
      (failure) =>
          emit(ProductsScreenState.failure(failureMessage: failure.code)),
      (products) => emit(ProductsScreenState.success(products: products)),
    );
  }

  Future<void> retryLoad() async {
    if (_lastFilter != null) await loadProducts(_lastFilter!);
  }
}
