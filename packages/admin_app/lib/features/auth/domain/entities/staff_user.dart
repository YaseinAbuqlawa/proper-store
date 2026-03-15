import 'package:freezed_annotation/freezed_annotation.dart';

import 'staff_role.dart';

part 'staff_user.freezed.dart';
part 'staff_user.g.dart';

@freezed
abstract class StaffModel with _$StaffModel {
  const factory StaffModel({
    required String uid,
    required String email,
    required StaffRole role,
  }) = _StaffModel;

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);
}
