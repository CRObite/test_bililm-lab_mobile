
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

import '../../config/handleErrorResponse.dart';

class LoginRepository {


  Dio dio = Dio();

  LoginRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> logInByIIN(String iin, String password) async {
    try {

      final response = await dio.post(
        AppApiUrls.userLogin,
        data: {"iin": iin, "password": password},
      );

      print(response.data);

      CurrentUser.currentTestUser = UserWithJwt.fromJson(response.data);

      await SharedPreferencesOperator.saveUserWithJwt(CurrentUser.currentTestUser!);

      return CustomResponse(200, '', null);

    } catch (e) {

      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> userGetMe() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        AppApiUrls.getMe,
      );

      print(response.data);

      TestUser user = TestUser.fromJson(response.data);
      return CustomResponse(200,'',user);
    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> refreshToken(String token) async {
    try {

      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.post(
        AppApiUrls.refreshToken,
        data: {
          "refreshToken": token
        },
      );

      print(response.data);

      CurrentUser.currentTestUser = UserWithJwt.fromJson(response.data);
      await SharedPreferencesOperator.saveUserWithJwt(CurrentUser.currentTestUser!);

      return CustomResponse(200, '', null);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


}
