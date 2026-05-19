import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/features/cart/domain/use_cases/load_cart_items_use_case.dart';
import 'package:proper_store/features/cart/domain/use_cases/save_cart_items_use_case.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final SaveCartItemsUseCase _saveCartItems;
  final LoadCartItemsUseCase _loadCartItems;

  String? _currentUserId;
  bool _isAdding = false;
  Timer? _addDebounceTimer;

  CartCubit({
    required SaveCartItemsUseCase saveCartItems,
    required LoadCartItemsUseCase loadCartItems,
  })  : _saveCartItems = saveCartItems,
        _loadCartItems = loadCartItems,
        super(CartState(cartState: CartStates.initial));

  Future<void> loadCart(String customerId) async {
    final guestItems = List<CartItemModel>.from(state.products);
    _currentUserId = customerId;
    final result = await _loadCartItems(customerId: customerId);
    if (_currentUserId != customerId) return; // stale request — user switched
    result.fold(
      (failure) {
        // Load failed — persist guest items if any, otherwise surface the error.
        if (guestItems.isNotEmpty) {
          _syncToFirestore();
        } else {
          emit(state.copyWith(
            cartState: CartStates.failure,
            errorMessage: failure.code,
          ));
        }
      },
      (savedItems) {
        if (guestItems.isEmpty) {
          emit(state.copyWith(products: savedItems));
        } else {
          // Guest items take priority; append saved items not already present
          final merged = [...guestItems];
          for (final saved in savedItems) {
            if (!merged.any((g) => g.id == saved.id)) {
              merged.add(saved);
            }
          }
          emit(state.copyWith(products: merged));
          _syncToFirestore();
        }
      },
    );
  }

  void addProductToCart(CartItemModel product) {
    if (_isAdding) return;
    _isAdding = true;
    _addDebounceTimer?.cancel();
    _addDebounceTimer = Timer(
      const Duration(milliseconds: 300),
      () => _isAdding = false,
    );

    if (state.products.any((p) => p.id == product.id)) {
      changeProductQuantity(
        changeQuantityType: ChangeQuantityType.increase,
        productId: product.id,
      );
    } else {
      emit(state.copyWith(products: [...state.products, product]));
      _syncToFirestore();
    }
  }

  void removeFromCart(String productId) {
    emit(
      state.copyWith(
        products: state.products.where((p) => p.id != productId).toList(),
      ),
    );
    _syncToFirestore();
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
    _syncToFirestore();
  }

  void clearCart() {
    emit(state.copyWith(cartState: CartStates.initial, products: []));
    _syncToFirestore();
    _currentUserId = null;
  }

  void _clearSyncError() {
    if (state.syncError) {
      emit(state.copyWith(syncError: false));
    }
  }

  void _syncToFirestore() {
    final uid = _currentUserId;
    if (uid == null) return;
    _saveCartItems(customerId: uid, items: state.products).then(
      (result) => result.fold(
        (_) {
          if (!isClosed) emit(state.copyWith(syncError: true));
        },
        (_) {
          if (!isClosed) _clearSyncError();
        },
      ),
    );
  }

  @override
  Future<void> close() {
    _addDebounceTimer?.cancel();
    return super.close();
  }
}
