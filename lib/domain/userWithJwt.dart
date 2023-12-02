import 'package:test_bilimlab_project/domain/testUser.dart';

class UserWithJwt{
  String _accessToken;
  TestUser _testUser;

  UserWithJwt(this._accessToken, this._testUser);

  TestUser get testUser => _testUser;

  set testUser(TestUser value) {
    _testUser = value;
  }

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
  }
}