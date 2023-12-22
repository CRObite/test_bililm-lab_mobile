
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

import '../../config/handleErrorResponse.dart';

class LoginRepository {


  Dio dio = Dio();

  Future<CustomResponse> logInByIIN(String iin, String password) async {
    try {
      final response = await dio.post(
        AppApiUrls.userLogin,
        data: {"iin": iin, "password": password},
      );

      CurrentUser.currentTestUser = UserWithJwt( response.data['accessToken'],TestUser.fromJson(response.data['testUser']));
      return CustomResponse(200, '', null);

    } catch (e) {
      print('asdasdadas');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<TestUser?> userGetMe() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        AppApiUrls.getMe,
      );

      print(response.data);

      TestUser user = TestUser.fromJson(response.data);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }


}
