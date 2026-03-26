import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:admin/features/products/domain/use_cases/get_products_by_ids_use_case.dart';
import 'customer_favorites_state.dart';

@injectable
class CustomerFavoritesCubit extends Cubit<CustomerFavoritesState> {
  final GetProductsByIdsUseCase _getProductsByIds;

  CustomerFavoritesCubit({required GetProductsByIdsUseCase getProductsByIds})
      : _getProductsByIds = getProductsByIds,
        super(CustomerFavoritesLoading());

  Future<void> loadFavorites(List<String> ids) async {
    emit(CustomerFavoritesLoading());

    if (ids.isEmpty) {
      emit(CustomerFavoritesEmpty());
      return;
    }

    final result = await _getProductsByIds(ids);
    result.fold(
      (failure) => emit(CustomerFavoritesFailure(failure.code)),
      (products) => products.isEmpty
          ? emit(CustomerFavoritesEmpty())
          : emit(CustomerFavoritesLoaded(products)),
    );
  }
}
