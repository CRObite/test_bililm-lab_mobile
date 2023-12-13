// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultSubject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultSubject _$ResultSubjectFromJson(Map<String, dynamic> json) =>
    ResultSubject(
      json['subjectName'] as String,
      json['maxScore'] as int,
      json['score'] as int,
    );

Map<String, dynamic> _$ResultSubjectToJson(ResultSubject instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'maxScore': instance.maxScore,
      'score': instance.score,
    };
