// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userWithJwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithJwt _$UserWithJwtFromJson(Map<String, dynamic> json) => UserWithJwt(
      json['accessToken'] as String,
      TestUser.fromJson(json['testUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWithJwtToJson(UserWithJwt instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'testUser': instance.testUser,
    };
