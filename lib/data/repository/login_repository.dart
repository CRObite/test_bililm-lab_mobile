
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/domain/city.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/region.dart';
import 'package:test_bilimlab_project/domain/school.dart';
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

      final response = await dio.post(
        AppApiUrls.refreshToken,
        queryParameters: {
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

  Future<CustomResponse> recoverPassword(String email, String iin) async {
    try {

      print(email);
      print(iin);


      final response = await dio.put(
        AppApiUrls.recoverPassword,
        data:{
          "email": email,
          "iin": iin
        },
      );

      print(response.data);

      return CustomResponse(200, '', null);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> register(
      String email,
      int phoneNumber,
      String firstName,
      String? middleName,
      String lastName,
      String iin,
      Region? region,
      City? city,
      School? school) async {

    try {

      final response = await dio.post(
        AppApiUrls.registration,
        data: {
          "email": email,
          "phoneNumber": phoneNumber,
          "firstName": firstName,
          "middleName": middleName,
          "lastName": lastName,
          "iin": iin,
          "region": region,
          "city": city,
          "school": school,
        },
      );

      print(response.data);


      return CustomResponse(200, '', null);


    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }




}
