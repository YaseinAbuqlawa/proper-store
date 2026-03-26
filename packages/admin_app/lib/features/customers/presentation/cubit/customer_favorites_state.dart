import 'package:proper_store_shared/models/product_model.dart';

sealed class CustomerFavoritesState {}

class CustomerFavoritesLoading extends CustomerFavoritesState {}

class CustomerFavoritesLoaded extends CustomerFavoritesState {
  final List<ProductModel> products;
  CustomerFavoritesLoaded(this.products);
}

class CustomerFavoritesEmpty extends CustomerFavoritesState {}

class CustomerFavoritesFailure extends CustomerFavoritesState {
  final String message;
  CustomerFavoritesFailure(this.message);
}
