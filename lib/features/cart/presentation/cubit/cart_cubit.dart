import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cartState: CartStates.initial));

  void addProductToCart(ProductModel product) {
    emit(state.copyWith(products: [...state.products, product]));
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
    List<ProductModel> updatedProducts = List.from(state.products);
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
}
