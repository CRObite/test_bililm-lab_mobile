// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoresData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoresData _$ScoresDataFromJson(Map<String, dynamic> json) => ScoresData(
      (json['dates'] as List<dynamic>).map((e) => e as String?).toList(),
      (json['scores'] as List<dynamic>).map((e) => e as int?).toList(),
      json['maxScore'] as int?,
    );

Map<String, dynamic> _$ScoresDataToJson(ScoresData instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'scores': instance.scores,
      'maxScore': instance.maxScore,
    };
