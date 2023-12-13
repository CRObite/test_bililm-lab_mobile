// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolClass _$SchoolClassFromJson(Map<String, dynamic> json) => SchoolClass(
      json['id'] as int,
      json['name'] as String,
      json['testTimeLimit'] as String,
      json['createdDate'] as String,
      json['timeInMilliseconds'] as int,
    );

Map<String, dynamic> _$SchoolClassToJson(SchoolClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'testTimeLimit': instance.testTimeLimit,
      'createdDate': instance.createdDate,
      'timeInMilliseconds': instance.timeInMilliseconds,
    };
