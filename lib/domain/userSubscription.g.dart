// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSubscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscription _$UserSubscriptionFromJson(Map<String, dynamic> json) =>
    UserSubscription(
      Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      json['subscriptionDate'] as String?,
      json['endDate'] as String?,
      json['entTestPassedLimit'] as int?,
      json['modoTestPassedLimit'] as int?,
      json['active'] as bool?,
    );

Map<String, dynamic> _$UserSubscriptionToJson(UserSubscription instance) =>
    <String, dynamic>{
      'subscription': instance.subscription,
      'subscriptionDate': instance.subscriptionDate,
      'endDate': instance.endDate,
      'entTestPassedLimit': instance.entTestPassedLimit,
      'modoTestPassedLimit': instance.modoTestPassedLimit,
      'active': instance.active,
    };
