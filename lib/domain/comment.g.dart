// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as int,
      json['text'] as String,
      json['type'] as String,
      json['dateTime'] as String,
      json['post'] == null
          ? null
          : PostItem.fromJson(json['post'] as Map<String, dynamic>),
      json['university'] == null
          ? null
          : University.fromJson(json['university'] as Map<String, dynamic>),
      json['specialization'] == null
          ? null
          : Specialization.fromJson(
              json['specialization'] as Map<String, dynamic>),
      AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': instance.type,
      'dateTime': instance.dateTime,
      'post': instance.post,
      'university': instance.university,
      'specialization': instance.specialization,
      'appUser': instance.appUser,
    };
