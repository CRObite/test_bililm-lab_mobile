

import 'package:test_bilimlab_project/domain/testQuestion.dart';

class TestSubject{
  int _id;
  String _name;
  List<TestQuestion> listOfQuestion;

  TestSubject(this._id, this._name, this.listOfQuestion);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}