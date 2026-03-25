import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/get_all_products_use_case.dart';
import 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductsCubit({
    required this.getAllProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(const ProductsState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading));
    final result = await getAllProductsUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          failureMessage: failure.code,
        ),
      ),
      (tuple) {
        final (products, lastDoc) = tuple;
        emit(
          state.copyWith(
            status: ProductsStatus.loaded,
            products: products,
            hasMore: products.length == 20,
            lastDoc: lastDoc,
            failureMessage: "",
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == ProductsStatus.loadingMore) return;

    emit(state.copyWith(status: ProductsStatus.loadingMore));

    final result = await getAllProductsUseCase.call(startAfter: state.lastDoc);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.loaded,
          hasMore: false,
          failureMessage: failure.code,
        ),
      ),
      (tuple) {
        final (newProducts, lastDoc) = tuple;
        emit(
          state.copyWith(
            status: ProductsStatus.loaded,
            products: [...state.products, ...newProducts],
            hasMore: newProducts.length == 20,
            lastDoc: lastDoc,
            failureMessage: "",
          ),
        );
      },
    );
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> deleteProduct(String id) async {
    final result = await deleteProductUseCase.call(id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          failureMessage: failure.code,
        ),
      ),
      (_) {
        emit(
          state.copyWith(
            products: state.products.where((p) => p.id != id).toList(),
            failureMessage: "",
          ),
        );
      },
    );
  }
}
