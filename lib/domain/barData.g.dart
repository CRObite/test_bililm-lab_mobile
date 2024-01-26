// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarData _$BarDataFromJson(Map<String, dynamic> json) => BarData(
      json['passedTestCount'] as int?,
      json['lastTestScore'] as int?,
      json['averageTestScore'] as int?,
      ScoresData.fromJson(json['general'] as Map<String, dynamic>),
      (json['subjects'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ScoresData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$BarDataToJson(BarData instance) => <String, dynamic>{
      'passedTestCount': instance.passedTestCount,
      'lastTestScore': instance.lastTestScore,
      'averageTestScore': instance.averageTestScore,
      'general': instance.general,
      'subjects': instance.subjects,
    };
