
import 'package:dio/dio.dart';

import '../domain/customResponse.dart';

class HandleErrorResponse {
  static CustomResponse handleErrorResponse(dynamic error) {
    if (error is DioError) {
      print(error.response?.statusCode);
      print('asdadasdasdasdasda');
      print(error.response?.data['detail']);
      return CustomResponse(
        error.response?.statusCode ?? 500,
        error.response?.data['detail'],
        null,
      );
    } else {
      return CustomResponse(500, 'Server Error', null);
    }
  }
}