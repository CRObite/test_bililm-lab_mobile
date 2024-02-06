// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialization _$SpecializationFromJson(Map<String, dynamic> json) =>
    Specialization(
      json['id'] as int,
      json['name'] as String,
      json['grandScore'] as int?,
      json['grandCount'] as int?,
      json['averageSalary'] as int?,
      json['demand'] as String,
      json['code'] as String,
      json['description'] as String,
      (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['universities'] as List<dynamic>?)
          ?.map((e) => UniversityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecializationToJson(Specialization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'grandScore': instance.grandScore,
      'grandCount': instance.grandCount,
      'averageSalary': instance.averageSalary,
      'demand': instance.demand,
      'code': instance.code,
      'description': instance.description,
      'subjects': instance.subjects,
      'universities': instance.universities,
    };
