import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/revision.dart';
import 'package:test_bilimlab_project/utils/TestTypeEnum.dart';
import '../../domain/entTest.dart';

import '../../domain/modoTest.dart';
import '../../utils/AppApiUrls.dart';


class TestRepository {

  Dio dio = Dio();

  Future<CustomResponse> generateEntTest(TestTypeEnum type , int? firstSubjectId, int? secondSubjectId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.post(
        AppApiUrls.generateEntTest,
        data: {
          "firstSubjectId": firstSubjectId,
          "secondSubjectId": secondSubjectId,
          "type": type.name,
        }
      );

      print(response.data);

      EntTest test = EntTest.fromJson(response.data);

      return CustomResponse(200, '', test);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> endEntTest(String entTestId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.put(
          '${AppApiUrls.endEntTest}/$entTestId'
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> answerEntTest(String entTestId,int questionId,int optionId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.post(
          AppApiUrls.saveAnswerEntTest,
          data: {
            "entTestId": entTestId,
            "questionId": questionId,
            "optionId": optionId
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> comparisonAnswerEntTest(String entTestId,int questionId,int optionId, int subOptionId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.post(
          AppApiUrls.saveAnswerEntTest,
          data: {
            "entTestId": entTestId,
            "questionId": questionId,
            "optionId": optionId,
            "subOptionId": subOptionId,
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> deleteAnswerEntTest(String entTestId,int questionId,int optionId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.delete(
          AppApiUrls.deleteAnswerEntTest,
          data: {
            "entTestId": entTestId,
            "questionId": questionId,
            "optionId": optionId
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> comparisonDeleteAnswerEntTest(String entTestId,int questionId,int optionId, int subOptionId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.delete(
          AppApiUrls.deleteAnswerEntTest,
          data: {
            "entTestId": entTestId,
            "questionId": questionId,
            "optionId": optionId,
            "subOptionId": subOptionId,
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getLastEntTest() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
          AppApiUrls.getLastEntTest,
      );

      print(response.data);

      EntTest test = EntTest.fromJson(response.data);

      return CustomResponse(200, '', test);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getAllByUser(int page, int size) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getAllByUser,
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      print(response.data);

      Revision revision = Revision.fromJson(response.data);

      return CustomResponse(200, '', revision);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getStatistics() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getStatisticByUser,
      );

      print(response.data);

      BarData data = BarData.fromJson(response.data);

      return CustomResponse(200, '', data);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getMistakes(String testId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        '${AppApiUrls.getTestMistakes}$testId',
      );

      print(response.data);

      EntTest entTest = EntTest.fromJson(response.data);

      return CustomResponse(200, '', entTest);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> generateSchoolTest(int schoolClassId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.post(
          AppApiUrls.generateSchoolTest,
          data: {
            "schoolClassId": schoolClassId,
          }
      );

      print(response.data);

      ModoTest test = ModoTest.fromJson(response.data);

      return CustomResponse(200, '', test);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> endSchoolTest(String testId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.put(
          '${AppApiUrls.endSchoolTest}/$testId',

      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> answerSchoolTest(String testId,int questionId,int optionId) async {

    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.post(
          AppApiUrls.saveAnswerSchoolTest,
          data: {
            "schoolTestId": testId,
            "schoolQuestionId": questionId,
            "schoolOptionId": optionId
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> deleteAnswerSchoolTest(String testId,int questionId,int optionId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.delete(
          AppApiUrls.deleteAnswerSchoolTest,
          data: {
            "schoolTestId": testId,
            "schoolQuestionId": questionId,
            "schoolOptionId": optionId
          }
      );

      print(response.data);
      return CustomResponse(200, '', null);

    } catch (e) {
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


  Future<CustomResponse> getLastSchoolTest() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';
      final response = await dio.get(
        AppApiUrls.getLastSchoolTest,
      );

      print(response.data);

      ModoTest test = ModoTest.fromJson(response.data);

      return CustomResponse(200, '', test);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }



}
