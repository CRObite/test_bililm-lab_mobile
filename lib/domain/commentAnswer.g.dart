// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentAnswer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentAnswer _$CommentAnswerFromJson(Map<String, dynamic> json) =>
    CommentAnswer(
      json['id'] as int,
      json['text'] as String,
      json['dateTime'] as String,
      Comment.fromJson(json['comment'] as Map<String, dynamic>),
      TestUser.fromJson(json['appUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentAnswerToJson(CommentAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'dateTime': instance.dateTime,
      'comment': instance.comment,
      'appUser': instance.appUser,
    };
