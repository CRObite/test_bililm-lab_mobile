
import 'package:test_bilimlab_project/domain/customResponse.dart';

import '../../utils/TestTypeEnum.dart';
import '../repository/test_repository.dart';

class TestService{
  Future<CustomResponse> generateEntTest(TestTypeEnum type , int? firstSubjectId, int? secondSubjectId) async {
    return await TestRepository().generateEntTest(type , firstSubjectId,secondSubjectId);
  }


  Future<CustomResponse> endEntTest(String entTestId) async {
    return await TestRepository().endEntTest(entTestId);
  }

  Future<CustomResponse> answerEntTest(String entTestId,int questionId,int optionId) async {
    return await TestRepository().answerEntTest(entTestId,questionId,optionId);
  }

  Future<CustomResponse> deleteAnswerEntTest(String entTestId,int questionId,int optionId) async {
    return await TestRepository().deleteAnswerEntTest( entTestId, questionId, optionId);
  }

  Future<CustomResponse> getLastEntTest() async {
    return await TestRepository().getLastEntTest();
  }

  Future<CustomResponse> generateSchoolTest(int schoolClassId) async {
    return await TestRepository().generateSchoolTest(schoolClassId);
  }


  Future<CustomResponse> endSchoolTest(String entTestId) async {
    return await TestRepository().endSchoolTest(entTestId);
  }

  Future<CustomResponse> answerSchoolTest(String entTestId,int questionId,int optionId) async {
    return await TestRepository().answerSchoolTest(entTestId,questionId,optionId);
  }

  Future<CustomResponse> deleteAnswerSchoolTest(String entTestId,int questionId,int optionId) async {
    return await TestRepository().deleteAnswerSchoolTest( entTestId, questionId, optionId);
  }

  Future<CustomResponse> getLastSchoolTest() async {
    return await TestRepository().getLastEntTest();
  }
}