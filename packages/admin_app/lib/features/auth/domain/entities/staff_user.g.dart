// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffModel _$StaffModelFromJson(Map<String, dynamic> json) => _StaffModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$StaffRoleEnumMap, json['role']),
);

Map<String, dynamic> _$StaffModelToJson(_StaffModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'role': _$StaffRoleEnumMap[instance.role]!,
    };

const _$StaffRoleEnumMap = {StaffRole.admin: 'admin', StaffRole.cs: 'cs'};
