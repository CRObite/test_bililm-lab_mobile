import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

class UniversityRepository {
  Dio dio = Dio();

  UniversityRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getAllUniversity() async {
    try {
      dio.options.headers['Authorization'] =
      'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getAllUniversity}',

      );
      print(response.data['items']);

      List<University> university = (response.data['items'] as List<dynamic>)
          .map((postsData) => University.fromJson(postsData)).toList();

      print(university);
      return CustomResponse(200, '', university);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getUniversityById(int id) async {
    try {
      dio.options.headers['Authorization'] =
      'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getUniversityById}${id}',
      );
      print(response.data);

      University university = University.fromJson(response.data);

      print(university);
      return CustomResponse(200, '', university);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }
}