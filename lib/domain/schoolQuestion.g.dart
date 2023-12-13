// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schoolQuestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolQuestion _$SchoolQuestionFromJson(Map<String, dynamic> json) =>
    SchoolQuestion(
      json['id'] as int,
      json['question'] as String,
      json['multipleAnswers'] as bool,
      (json['checkedAnswers'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['schoolOptions'] as List<dynamic>)
          .map((e) => TestOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolQuestionToJson(SchoolQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'multipleAnswers': instance.multipleAnswers,
      'checkedAnswers': instance.checkedAnswers,
      'mediaFiles': instance.mediaFiles,
      'schoolOptions': instance.schoolOptions,
    };
