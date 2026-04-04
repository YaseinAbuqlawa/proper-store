import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/top_selling_item.dart';

part 'top_selling_item_model.freezed.dart';
part 'top_selling_item_model.g.dart';

@freezed
abstract class TopSellingItemModel with _$TopSellingItemModel {
  const TopSellingItemModel._();

  const factory TopSellingItemModel({
    required String id,
    required String productId,
    required String productName,
    required String variantKey,
    required String variantName,
    required String imageUrl,
    required int totalSold,
  }) = _TopSellingItemModel;

  factory TopSellingItemModel.fromJson(Map<String, dynamic> json) =>
      _$TopSellingItemModelFromJson(json);

  TopSellingItem toEntity() => TopSellingItem(
    id: id,
    productId: productId,
    productName: productName,
    variantKey: variantKey,
    variantName: variantName,
    imageUrl: imageUrl,
    totalSold: totalSold,
  );
}
