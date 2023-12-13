// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testOption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestOption _$TestOptionFromJson(Map<String, dynamic> json) => TestOption(
      json['id'] as int,
      json['text'] as String,
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestOptionToJson(TestOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'mediaFiles': instance.mediaFiles,
    };
