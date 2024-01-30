// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUser _$TestUserFromJson(Map<String, dynamic> json) => TestUser(
      json['id'] as int,
      json['firstName'] as String,
      json['middleName'] as String?,
      json['lastName'] as String,
      json['iin'] as String,
      json['phoneNumber'] as String,
      json['permissionForTest'] as bool,
      json['permissionForModo'] as bool,
      json['subscription'] == null
          ? null
          : UserSubscription.fromJson(
              json['subscription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestUserToJson(TestUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'iin': instance.iin,
      'phoneNumber': instance.phoneNumber,
      'permissionForTest': instance.permissionForTest,
      'permissionForModo': instance.permissionForModo,
      'subscription': instance.subscription,
    };
