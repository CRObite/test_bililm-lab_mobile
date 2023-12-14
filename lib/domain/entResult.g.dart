// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntResult _$EntResultFromJson(Map<String, dynamic> json) => EntResult(
      TotalResult.fromJson(json['totalResult'] as Map<String, dynamic>),
      (json['subjectsResult'] as List<dynamic>)
          .map((e) => ResultSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EntResultToJson(EntResult instance) => <String, dynamic>{
      'totalResult': instance.totalResult,
      'subjectsResult': instance.subjectsResult,
    };
