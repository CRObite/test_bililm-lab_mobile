
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import '../domain/currentUser.dart';
import '../presentation/Widgets/ServerErrorDialog.dart';

class ResponseValidator{
  static dynamic validation(CustomResponse currentResponse,BuildContext context) async {
    if(currentResponse.code == 401){
      if(CurrentUser.currentTestUser != null){
        CustomResponse response = await LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);

        if(response.code == 200){
          Navigator.pushReplacementNamed(context, '/app');

          return null;
        }else{
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');

          return null;
        }
      }else {
        SharedPreferencesOperator.clearUserWithJwt();
        Navigator.pushReplacementNamed(context, '/');

        return null;
      }
    } else if(currentResponse.code == 500){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ServerErrorDialog();
        },
      );

      return null;
    }


    return currentResponse.body;
  }
}