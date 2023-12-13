// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mediaFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaFile _$MediaFileFromJson(Map<String, dynamic> json) => MediaFile(
      json['id'] as String,
      json['name'] as String,
      json['originalName'] as String,
      json['extensions'] as String,
      json['url'] as String,
      json['createdDate'] as String,
    );

Map<String, dynamic> _$MediaFileToJson(MediaFile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'originalName': instance.originalName,
      'extensions': instance.extensions,
      'url': instance.url,
      'createdDate': instance.createdDate,
    };
