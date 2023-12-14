// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeSubject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeSubject _$TypeSubjectFromJson(Map<String, dynamic> json) => TypeSubject(
      json['type'] as String,
      json['score'] as int,
      (json['subjectsResult'] as List<dynamic>)
          .map((e) => ResultSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeSubjectToJson(TypeSubject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'score': instance.score,
      'subjectsResult': instance.subjectsResult,
    };
