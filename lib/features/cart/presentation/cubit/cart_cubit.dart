import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/cart/data/models/cart_item_model.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cartState: CartStates.initial));

  void addProductToCart(CartItemModel product) {
    if (state.products.any((p) => p.id == product.id)) {
      changeProductQuantity(
        changeQuantityType: ChangeQuantityType.increase,
        productId: product.id,
      );
    } else {
      emit(state.copyWith(products: [...state.products, product]));
    }
  }

  void removeFromCart(String productId) {
    emit(
      state.copyWith(
        products: state.products.where((p) => p.id != productId).toList(),
      ),
    );
  }

  void changeProductQuantity({
    required ChangeQuantityType changeQuantityType,
    required String productId,
  }) {
    List<CartItemModel> updatedProducts = List.from(state.products);
    final index = updatedProducts.indexWhere((p) => p.id == productId);

    if (index == -1) return;

    final currentProduct = updatedProducts[index];

    if (changeQuantityType == ChangeQuantityType.increase) {
      updatedProducts[index] = currentProduct.copyWith(
        quantity: currentProduct.quantity + 1,
      );
    } else {
      if (currentProduct.quantity > 1) {
        updatedProducts[index] = currentProduct.copyWith(
          quantity: currentProduct.quantity - 1,
        );
      } else {
        updatedProducts.removeAt(index);
      }
    }

    emit(state.copyWith(products: updatedProducts));
  }

  void clearCart() {
    emit(state.copyWith(cartState: CartStates.initial, products: []));
  }
}
