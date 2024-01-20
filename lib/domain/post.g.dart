// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int,
      json['title'] as String?,
      json['description'] as String?,
      json['dateTime'] as String?,
      json['mediaFiles'] == null
          ? null
          : MediaFile.fromJson(json['mediaFiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime,
      'mediaFiles': instance.mediaFiles,
    };
