// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      json['id'] as int,
      json['name'] as String,
      json['permissionForTest'] as bool?,
      json['permissionForModo'] as bool?,
      json['city'] as String?,
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissionForTest': instance.permissionForTest,
      'permissionForModo': instance.permissionForModo,
      'city': instance.city,
    };
