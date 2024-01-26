

import   'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/userWithJwt.dart';

class SharedPreferencesOperator {
  static const String keyUserWithJwt = 'currentUser';

  static Future<void> saveUserWithJwt(UserWithJwt userWithJwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userWithJwtJson = jsonEncode(userWithJwt.toJson());
    await prefs.setString(keyUserWithJwt, userWithJwtJson);
  }

  static Future<UserWithJwt?> getUserWithJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userWithJwtJson = prefs.getString(keyUserWithJwt);

    if (userWithJwtJson != null) {
      Map<String, dynamic> userWithJwtMap = jsonDecode(userWithJwtJson);
      return UserWithJwt.fromJson(userWithJwtMap);
    }

    return null;
  }

  static Future<void> clearUserWithJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUserWithJwt);
  }

  static Future<bool> containsUserWithJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(keyUserWithJwt);
  }
}