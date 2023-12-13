
import 'package:get/get.dart';
import 'package:test_bilimlab_project/config/network_controller.dart';

class DependencyInjection {
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}