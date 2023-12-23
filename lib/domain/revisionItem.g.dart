// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revisionItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevisionItem _$RevisionItemFromJson(Map<String, dynamic> json) => RevisionItem(
      json['id'] as int,
      json['testUser'] == null
          ? null
          : TestUser.fromJson(json['testUser'] as Map<String, dynamic>),
      TotalResult.fromJson(json['totalResult'] as Map<String, dynamic>),
      (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      json['type'] as String,
      json['passed'] as bool,
      json['passedDate'] as String,
    );

Map<String, dynamic> _$RevisionItemToJson(RevisionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testUser': instance.testUser,
      'totalResult': instance.totalResult,
      'subjects': instance.subjects,
      'type': instance.type,
      'passed': instance.passed,
      'passedDate': instance.passedDate,
    };
