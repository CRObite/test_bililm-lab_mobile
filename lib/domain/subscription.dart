
import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int id;
  String? name;
  String? description;
  double? price;
  int? durationInDay;
  int? limitToDay;

  Subscription(this.id, this.name, this.description, this.price,
      this.durationInDay, this.limitToDay);


  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}