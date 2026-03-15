import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/products/domain/use_cases/get_all_products_use_case.dart';
import 'package:proper_store/core/products/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:proper_store/core/products/domain/use_cases/get_products_by_collection_use_case.dart';

part 'products_screen_cubit.freezed.dart';
part 'products_screen_state.dart';

@injectable
class ProductsScreenCubit extends Cubit<ProductsScreenState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final GetProductsByCollectionUseCase getProductsByCollectionUseCase;

  ProductFilter? _lastFilter;
  DocumentSnapshot? _cursor;
  List<ProductModel> _products = [];

  ProductsScreenCubit({
    required this.getAllProductsUseCase,
    required this.getProductsByCategoryUseCase,
    required this.getProductsByCollectionUseCase,
  }) : super(const ProductsScreenState.initial());

  Future<void> loadProducts(ProductFilter filter) async {
    _lastFilter = filter;
    _cursor = null;
    _products = [];
    emit(const ProductsScreenState.loading());

    final result = await _fetchPage(filter, startAfter: null);
    result.fold(
      (failure) =>
          emit(ProductsScreenState.failure(failureMessage: failure.code)),
      (page) {
        final (newProducts, cursor) = page;
        _products = newProducts;
        _cursor = cursor;
        emit(ProductsScreenState.paginated(
          products: _products,
          hasMore: cursor != null,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! _Paginated) return;
    if (!current.hasMore || current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true));

    final result = await _fetchPage(_lastFilter!, startAfter: _cursor);
    result.fold(
      (_) => emit(current.copyWith(isLoadingMore: false)),
      (page) {
        final (newProducts, cursor) = page;
        _products = [..._products, ...newProducts];
        _cursor = cursor;
        emit(ProductsScreenState.paginated(
          products: _products,
          hasMore: cursor != null,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> retryLoad() async {
    if (_lastFilter != null) await loadProducts(_lastFilter!);
  }

  Future<dynamic> _fetchPage(
    ProductFilter filter, {
    required DocumentSnapshot? startAfter,
  }) {
    return switch (filter) {
      ProductFilterAll() => getAllProductsUseCase(startAfter: startAfter),
      ProductFilterByCategory(:final category) =>
        getProductsByCategoryUseCase(category, startAfter: startAfter),
      ProductFilterByCollection(:final collection) =>
        getProductsByCollectionUseCase(collection, startAfter: startAfter),
    };
  }
}
