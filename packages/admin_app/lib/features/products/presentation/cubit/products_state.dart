import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proper_store_shared/models/product_model.dart';

part 'products_state.freezed.dart';

enum ProductsStatus { initial, loading, loaded, loadingMore, failure }

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(ProductsStatus.initial) ProductsStatus status,
    @Default([]) List<ProductModel> products,
    @Default(true) bool hasMore,
    DocumentSnapshot? lastDoc,
    @Default("") String failureMessage,
  }) = _ProductsState;
}
