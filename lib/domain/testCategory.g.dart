// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestCategory _$TestCategoryFromJson(Map<String, dynamic> json) => TestCategory(
      (json['questions'] as List<dynamic>?)
          ?.map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contextQuestions'] as List<dynamic>?)
          ?.map((e) => ContextTestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['multipleQuestions'] as List<dynamic>?)
          ?.map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['schoolQuestions'] as List<dynamic>?)
          ?.map((e) => SchoolQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['schoolMultipleQuestions'] as List<dynamic>?)
          ?.map((e) => SchoolQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['comparisonQuestions'] as List<dynamic>?)
          ?.map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestCategoryToJson(TestCategory instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'contextQuestions': instance.contextQuestions,
      'multipleQuestions': instance.multipleQuestions,
      'schoolQuestions': instance.schoolQuestions,
      'schoolMultipleQuestions': instance.schoolMultipleQuestions,
      'comparisonQuestions': instance.comparisonQuestions,
    };
