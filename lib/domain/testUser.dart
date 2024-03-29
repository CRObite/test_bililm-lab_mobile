

import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/userSubscription.dart';

part 'testUser.g.dart';

@JsonSerializable()
class TestUser {
  int id;
  String firstName;
  String? middleName;
  String lastName;
  String iin;
  String phoneNumber;
  bool permissionForTest;
  bool permissionForModo;
  UserSubscription? subscription;


  TestUser(
      this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.iin,
      this.phoneNumber,
      this.permissionForTest,
      this.permissionForModo,
      this.subscription);

  factory TestUser.fromJson(Map<String, dynamic> json) => _$TestUserFromJson(json);
  Map<String, dynamic> toJson() => _$TestUserToJson(this);

}