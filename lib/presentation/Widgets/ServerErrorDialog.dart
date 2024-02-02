import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';

import '../../utils/AppTexts.dart';

class ServerErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        SharedPreferencesOperator.clearUserWithJwt();
        Navigator.pushReplacementNamed(context, '/');
        return true;
      },
      child: AlertDialog(
        title: Text(AppText.serverError),
        content: Text(AppText.tryLater),
      ),
    );
  }
}
