
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/modoClass.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';


class SchoolClassRepository {


  Dio dio = Dio();

  Future<List<ModoClass>> getAllModoClass() async {

    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getAllModoClass,
      );

      List<dynamic> jsonResponse = response.data;
      List<ModoClass> modoClasses =  jsonResponse.map((json) => ModoClass.fromJson(json)).toList();
      print(modoClasses);
      return modoClasses;

    } catch (e) {
      print(e);
      return [];
    }
  }


}
