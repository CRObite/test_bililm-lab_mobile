
import 'dart:async';

import 'package:dio/dio.dart';

import '../domain/customResponse.dart';

class HandleErrorResponse {
  static CustomResponse handleErrorResponse(dynamic error) {
    if (error is DioException) {
      print(error.response?.data);
      print(error.response?.statusCode);
      print('asdadasdasdasdasda');
      print(error.response?.data['detail']);
      print(error.response?.data['message']);
      if (error is TimeoutException) {
        return CustomResponse(500, 'Server Error', null);
      }else{
        return CustomResponse(
          error.response?.statusCode ?? 500,
          error.response?.data['detail'],
          null,
        );
      }

    }else if(error is TypeError){
      return CustomResponse(601, 'Type Error: ${error.toString()}', null);
    } else {
      return CustomResponse(500, 'Server Error', null);
    }
  }
}