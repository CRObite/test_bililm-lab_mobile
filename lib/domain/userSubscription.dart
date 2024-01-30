import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/subscription.dart';


part 'userSubscription.g.dart';

@JsonSerializable()
class UserSubscription{
  Subscription subscription;
  String? subscriptionDate;
  String? endDate;
  int? entTestPassedLimit;
  int? modoTestPassedLimit;
  bool? active;

  UserSubscription(this.subscription, this.subscriptionDate, this.endDate,
      this.entTestPassedLimit, this.modoTestPassedLimit, this.active);

  factory UserSubscription.fromJson(Map<String, dynamic> json) => _$UserSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubscriptionToJson(this);
}