
import 'package:dio/dio.dart';

import '../domain/customResponse.dart';

class HandleErrorResponse {
  static CustomResponse handleErrorResponse(dynamic error) {
    if (error is DioError) {
      print(error.response?.data);
      return CustomResponse(
        error.response?.data['status'] ?? 500,
        error.response?.data['detail'],
        null,
      );
    } else {
      return CustomResponse(500, 'Server Error', null);
    }
  }
}