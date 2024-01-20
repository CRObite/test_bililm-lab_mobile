
import 'package:json_annotation/json_annotation.dart';

part 'appUser.g.dart';

@JsonSerializable()
class AppUser{
  int id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? login;
  int? iin;
  String? phoneNumber;

  AppUser(this.id, this.firstName, this.middleName, this.lastName, this.email,
      this.login, this.iin, this.phoneNumber);

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}