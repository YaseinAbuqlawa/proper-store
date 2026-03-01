import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/favorites/domain/use_cases/get_favorite_products_use_case.dart';
import 'package:proper_store/features/favorites/domain/use_cases/set_customer_favorites_use_case.dart';

part 'favorites_cubit.freezed.dart';
part 'favorites_state.dart';

@lazySingleton
class FavoritesCubit extends Cubit<FavoritesState> {
  final SetCustomerFavoritesUseCase setCustomerFavoritesUseCase;
  final GetFavoriteProductsUseCase getFavoriteProductsUseCase;
  FavoritesCubit({
    required this.setCustomerFavoritesUseCase,
    required this.getFavoriteProductsUseCase,
  }) : super(FavoritesState(favoriteProducts: []));

  Future<void> toggleFavorite({required ProductModel product}) async {
    if (sl<FirebaseAuth>().currentUser!.isAnonymous) {
      return emit(
        state.copyWith(
          failureMessage: "يجب تسجيل الدخول للاستفادة من هذه الميزة",
        ),
      );
    }
    final oldFavorites = List<ProductModel>.from(state.favoriteProducts);

    final updatedList = List<ProductModel>.from(state.favoriteProducts);
    final index = updatedList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      updatedList.removeAt(index);
      emit(state.copyWith(favoriteProducts: updatedList));
    } else {
      updatedList.add(product);
      emit(state.copyWith(favoriteProducts: updatedList));
    }

    try {
      await setCustomerFavorites();
    } catch (_) {
      emit(
        state.copyWith(
          favoriteProducts: oldFavorites,
          failureMessage: "لم تنجح عملية اضافة المنتج للمفضلة",
        ),
      );
    }
  }

  Future<void> setCustomerFavorites() async {
    if (sl<FirebaseAuth>().currentUser!.isAnonymous) return;
    final customerId = sl<FirebaseAuth>().currentUser!.uid;
    final favoritesList = state.favoriteProducts.map((p) => p.id).toList();

    await setCustomerFavoritesUseCase.call(
      customerId: customerId,
      favoritesList: favoritesList,
    );
  }

  void clearFailureMessage() {
    emit(state.copyWith(failureMessage: ""));
  }

  Future<void> getFavoriteProducts({
    required List<String> favoritesList,
  }) async {
    final result = await getFavoriteProductsUseCase.call(
      favoritesList: favoritesList,
    );
    result.fold(
      (serverFailure) =>
          emit(state.copyWith(failureMessage: serverFailure.errorMessage)),
      (productsList) => emit(state.copyWith(favoriteProducts: productsList)),
    );
  }

  void clearFavorites() {
    emit(state.copyWith(favoriteProducts: [], failureMessage: ""));
  }
}
