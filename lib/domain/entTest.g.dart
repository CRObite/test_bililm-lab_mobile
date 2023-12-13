// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntTest _$EntTestFromJson(Map<String, dynamic> json) => EntTest(
      json['id'] as String,
      json['startedDate'] as String,
      json['passedDate'] as String?,
      json['passed'] as bool,
      json['type'] as String,
      (json['questionsMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, TestCategory.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$EntTestToJson(EntTest instance) => <String, dynamic>{
      'id': instance.id,
      'startedDate': instance.startedDate,
      'passedDate': instance.passedDate,
      'passed': instance.passed,
      'type': instance.type,
      'questionsMap': instance.questionsMap,
    };
