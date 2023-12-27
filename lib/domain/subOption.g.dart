// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subOption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubOption _$SubOptionFromJson(Map<String, dynamic> json) => SubOption(
      json['id'] as int,
      json['text'] as String,
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubOptionToJson(SubOption instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'mediaFiles': instance.mediaFiles,
    };
