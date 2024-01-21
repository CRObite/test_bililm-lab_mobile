
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/utils/AppApiUrls.dart';

class SpecializationRepository{
  Dio dio = Dio();

  SpecializationRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getAllSpecialization(int index) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getAllSpecialization}',
          queryParameters: {
            "universityId": index,
          }
      );
      print(response.data['items']);

      List<Specialization> posts = (response.data['items'] as List<dynamic>)
          .map((specializationData) => Specialization.fromJson(specializationData)).toList();

      print(posts);
      return CustomResponse(200, '', posts);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getSpecializationById(int index) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
          '${AppApiUrls.getSpecializationById}${index}',
      );
      print(response.data);

      Specialization sp = Specialization.fromJson(response.data);

      return CustomResponse(200, '', sp);
    } catch (e) {
      print('$e');
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }
}