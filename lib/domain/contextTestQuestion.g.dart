// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contextTestQuestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContextTestQuestion _$ContextTestQuestionFromJson(Map<String, dynamic> json) =>
    ContextTestQuestion(
      json['content'] as String,
      (json['questions'] as List<dynamic>?)
          ?.map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['schoolQuestions'] as List<dynamic>?)
          ?.map((e) => SchoolQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContextTestQuestionToJson(
        ContextTestQuestion instance) =>
    <String, dynamic>{
      'content': instance.content,
      'questions': instance.questions,
      'schoolQuestions': instance.schoolQuestions,
    };
