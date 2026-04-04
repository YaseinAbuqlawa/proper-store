import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/out_of_stock_product.dart';

part 'out_of_stock_product_model.freezed.dart';
part 'out_of_stock_product_model.g.dart';

@freezed
abstract class OutOfStockProductModel with _$OutOfStockProductModel {
  const OutOfStockProductModel._();

  const factory OutOfStockProductModel({
    @JsonKey(name: "id") required String productId,
    required String name,
    @Default([]) List<String> outOfStockVariants,
    String? mainImageUrl,
  }) = _OutOfStockProductModel;

  factory OutOfStockProductModel.fromJson(Map<String, dynamic> json) =>
      _$OutOfStockProductModelFromJson(json);

  OutOfStockProduct toEntity() => OutOfStockProduct(
    productId: productId,
    name: name,
    outOfStockVariants: outOfStockVariants,
    mainImageUrl: mainImageUrl,
  );
}
