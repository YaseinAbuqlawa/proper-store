import 'package:injectable/injectable.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';

@lazySingleton
class BuildCartItemUseCase {
  /// Builds a [CartItemModel] from the given [product], using its
  /// [ProductModel.selectedColor] if set, or falling back to the first variant.
  /// Returns null if the product has no variants.
  CartItemModel? call(ProductModel product) {
    final variant =
        product.selectedColor ?? product.variants.values.firstOrNull;
    if (variant == null) return null;
    return CartItemModel.fromProductModel(
      product.copyWith(selectedColor: variant),
    );
  }
}
