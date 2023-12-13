
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class NetworkController extends GetxController{

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {

    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult){

    if(connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: const Text(
          'Интернет ажыратылды, интернетке қосылыңыз',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: AppColors.colorButton,
        icon: const Icon(Icons.wifi_off,color: Colors.white,size: 35,),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}