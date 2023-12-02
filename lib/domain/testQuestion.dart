
import 'package:test_bilimlab_project/utils/questionTypeEnum.dart';

class TestQuestion{
  int _id;
  String _question;
  List<String> _answers;
  int _correctAnswer;
  QuestionTypeEnum _questionType;


  TestQuestion(this._id, this._question, this._answers, this._correctAnswer,
      this._questionType);


  QuestionTypeEnum get questionType => _questionType;

  set questionType(QuestionTypeEnum value) {
    _questionType = value;
  }

  int get correctAnswer => _correctAnswer;

  set correctAnswer(int value) {
    _correctAnswer = value;
  }

  List<String> get answers => _answers;

  set answers(List<String> value) {
    _answers = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}