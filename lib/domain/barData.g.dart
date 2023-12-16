// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarData _$BarDataFromJson(Map<String, dynamic> json) => BarData(
      ScoresData.fromJson(json['general'] as Map<String, dynamic>),
      (json['subjects'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ScoresData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$BarDataToJson(BarData instance) => <String, dynamic>{
      'general': instance.general,
      'subjects': instance.subjects,
    };
