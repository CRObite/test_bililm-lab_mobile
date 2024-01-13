
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/modoResult.dart';

import '../../config/handleErrorResponse.dart';
import '../../domain/currentUser.dart';
import '../../domain/entResult.dart';
import '../../utils/AppApiUrls.dart';

class ResultRepository{
  Dio dio = Dio();

  ResultRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getResult() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        AppApiUrls.getResult,
      );

      EntResult result = EntResult.fromJson(response.data);

      return CustomResponse(200, '', result);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getSchoolResult() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        AppApiUrls.getSchoolResult,
      );

      ModoResult result = ModoResult.fromJson(response.data);

      return CustomResponse(200, '', result);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }



}