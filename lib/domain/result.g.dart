// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      TotalResult.fromJson(json['totalResult'] as Map<String, dynamic>),
      (json['subjectsResult'] as List<dynamic>)
          .map((e) => ResultSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'totalResult': instance.totalResult,
      'subjectsResult': instance.subjectsResult,
    };
