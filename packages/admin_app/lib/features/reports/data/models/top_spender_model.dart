import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/top_spender.dart';

part 'top_spender_model.freezed.dart';
part 'top_spender_model.g.dart';

@freezed
abstract class TopSpenderModel with _$TopSpenderModel {
  const TopSpenderModel._();

  const factory TopSpenderModel({
    required String customerId,
    required String name,
    required double totalSpent,
    required int orderCount,
    @Default(0) int refundCount,
  }) = _TopSpenderModel;

  factory TopSpenderModel.fromJson(Map<String, dynamic> json) =>
      _$TopSpenderModelFromJson(json);

  TopSpender toEntity() => TopSpender(
        customerId: customerId,
        name: name,
        totalSpent: totalSpent,
        orderCount: orderCount,
        refundCount: refundCount,
      );
}
