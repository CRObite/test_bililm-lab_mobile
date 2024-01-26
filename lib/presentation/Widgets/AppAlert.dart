

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:test_bilimlab_project/utils/AlertEnum.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class AppAlert {
  static void show(BuildContext context, String content, AlertEnum type){
    switch (type){
      case AlertEnum.Success :
        QuickAlert.show(context: context, type:QuickAlertType.success, text: content);
        break;
      case AlertEnum.Error :
        QuickAlert.show(context: context, type:QuickAlertType.error, text: content);
        break;
      case AlertEnum.Warning :
        QuickAlert.show(context: context, type:QuickAlertType.warning, text: content);
        break;
      case AlertEnum.Info :
        QuickAlert.show(context: context, type:QuickAlertType.info, text: content);
        break;
      case AlertEnum.Confirm :
        QuickAlert.show(
            context: context,
            type:QuickAlertType.confirm,
            text: content,
            title: AppText.quittingTheTest,
            confirmBtnText: AppText.no,
            cancelBtnText: AppText.yes,
            onCancelBtnTap:(){
              Navigator.pop(context);
              Navigator.pop(context);
            }
        );
        break;
      case AlertEnum.Loading :
        QuickAlert.show(context: context, type:QuickAlertType.loading, text: content, title:AppText.quittingTheTest);
        break;
    }
  }
}