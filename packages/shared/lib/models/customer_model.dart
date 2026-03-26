import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item_model.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
abstract class CustomerModel with _$CustomerModel {
  const factory CustomerModel({
    required String id,
    required String name,
    required String email,
    @Default('') String photoUrl,
    @Default([]) List<String> favoritesList,
    @Default(null) String? role,
    @Default('') String phone,
    @Default([]) List<CartItemModel> cartItems,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}
