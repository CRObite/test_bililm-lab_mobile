// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modoResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModoResult _$ModoResultFromJson(Map<String, dynamic> json) => ModoResult(
      TotalResult.fromJson(json['totalResult'] as Map<String, dynamic>),
      (json['typeSubjects'] as List<dynamic>)
          .map((e) => TypeSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModoResultToJson(ModoResult instance) =>
    <String, dynamic>{
      'totalResult': instance.totalResult,
      'typeSubjects': instance.typeSubjects,
    };
