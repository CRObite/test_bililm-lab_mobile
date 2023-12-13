
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

import '../../config/handleErrorResponse.dart';
import '../../domain/currentUser.dart';
import '../../domain/result.dart';
import '../../utils/AppApiUrls.dart';

class ResultRepository{
  Dio dio = Dio();

  Future<CustomResponse> getResult() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        AppApiUrls.getResult,
      );

      Result result = Result.fromJson(response.data);

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

      Result result = Result.fromJson(response.data);

      return CustomResponse(200, '', result);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }



}