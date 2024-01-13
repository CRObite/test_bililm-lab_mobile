import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import '../../domain/entSubject.dart';
import '../../utils/AppApiUrls.dart';

class SubjectRepository {


  Dio dio = Dio();

  SubjectRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }


  Future<List<EntSubject>> getAllEntSubject() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getAllSub,
      );

      List<dynamic> jsonResponse = response.data;
      List<EntSubject> entSubjectList =  jsonResponse.map((json) => EntSubject.fromJson(json)).toList();
      return entSubjectList;

    } catch (e) {
      return [];
    }
  }

  Future<List<EntSubject>> getEntSubjectInMSS(int subIndex) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getAllSubInMSS,
        queryParameters: {
          'subjectId': subIndex,
        }
      );

      List<dynamic> jsonResponse = response.data;
      List<EntSubject> entSubjectList =  jsonResponse.map((json) => EntSubject.fromJson(json)).toList();
      print(entSubjectList);
      return entSubjectList;

    } catch (e) {
      return [];
    }
  }


}
