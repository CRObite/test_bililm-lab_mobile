// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['totalCount'] as int,
      json['totalPages'] as int,
      (json['items'] as List<dynamic>)
          .map((e) => PostItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
