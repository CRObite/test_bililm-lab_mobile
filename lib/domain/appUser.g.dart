// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      json['id'] as int,
      json['firstName'] as String?,
      json['middleName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['login'] as String?,
      json['iin'] as int?,
      json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'login': instance.login,
      'iin': instance.iin,
      'phoneNumber': instance.phoneNumber,
    };
