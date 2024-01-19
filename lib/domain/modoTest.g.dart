// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modoTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModoTest _$ModoTestFromJson(Map<String, dynamic> json) => ModoTest(
      json['id'] as String,
      json['startedDate'] as String,
      json['passedDate'] as String?,
      json['passed'] as bool,
      SchoolClass.fromJson(json['schoolClass'] as Map<String, dynamic>),
      (json['typeSubjectQuestionMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) =>
                  MapEntry(k, TestCategory.fromJson(e as Map<String, dynamic>)),
            )),
      ),
      json['timeLimitInMilliseconds'] as int,
    );

Map<String, dynamic> _$ModoTestToJson(ModoTest instance) => <String, dynamic>{
      'id': instance.id,
      'startedDate': instance.startedDate,
      'passedDate': instance.passedDate,
      'passed': instance.passed,
      'schoolClass': instance.schoolClass,
      'typeSubjectQuestionMap': instance.typeSubjectQuestionMap,
      'timeLimitInMilliseconds': instance.timeLimitInMilliseconds,
    };
