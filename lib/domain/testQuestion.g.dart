// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testQuestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestQuestion _$TestQuestionFromJson(Map<String, dynamic> json) => TestQuestion(
      json['id'] as int,
      json['question'] as String,
      json['multipleAnswers'] as bool,
      (json['checkedAnswers'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['options'] as List<dynamic>)
          .map((e) => TestOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['recommendation'] as String?,
    );

Map<String, dynamic> _$TestQuestionToJson(TestQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'multipleAnswers': instance.multipleAnswers,
      'checkedAnswers': instance.checkedAnswers,
      'mediaFiles': instance.mediaFiles,
      'options': instance.options,
      'recommendation': instance.recommendation,
    };
