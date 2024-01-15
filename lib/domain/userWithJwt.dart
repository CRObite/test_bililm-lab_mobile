import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';

part 'userWithJwt.g.dart';

@JsonSerializable()
class UserWithJwt{
  String accessToken;
  String refreshToken;
  TestUser testUser;


  UserWithJwt(this.accessToken, this.refreshToken, this.testUser);

  factory UserWithJwt.fromJson(Map<String, dynamic> json) => _$UserWithJwtFromJson(json);
  Map<String, dynamic> toJson() => _$UserWithJwtToJson(this);

}