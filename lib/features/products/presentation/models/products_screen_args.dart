import 'package:proper_store/core/products/domain/entities/product_filter.dart';

class ProductsScreenArgs {
  final String title;
  final ProductFilter filter;

  const ProductsScreenArgs({required this.title, required this.filter});
}
