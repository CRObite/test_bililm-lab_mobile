import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';

class ResponseHandle{

  static void handleResponseError(CustomResponse response,BuildContext context) {
    if (response.code == 401 ) {
      refreshTokenOrRedirect(context);
    } else if (response.code == 500) {
      ResponseHandle.showServerErrorDialog(context);
    }
  }

  static void refreshTokenOrRedirect(BuildContext context) async {
    if (CurrentUser.currentTestUser != null) {
      CustomResponse response =
      await LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);
      if (response.code == 200) {
        Navigator.pushReplacementNamed(context, '/app');
      } else {
        handleLogout(context);
      }
    } else {
      handleLogout(context);
    }
  }

  static void handleLogout(BuildContext context) {
    SharedPreferencesOperator.clearUserWithJwt();
    Navigator.pushReplacementNamed(context, '/');
  }

  static void showServerErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ServerErrorDialog();
      },
    );
  }


}