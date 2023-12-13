
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/schoolQuestion.dart';
import 'package:test_bilimlab_project/domain/testQuestion.dart';

part 'contextTestQuestion.g.dart';

@JsonSerializable()
class ContextTestQuestion {
  String content;
  List<TestQuestion>? questions;
  List<SchoolQuestion>? schoolQuestions;


  ContextTestQuestion(this.content, this.questions, this.schoolQuestions);

  factory ContextTestQuestion.fromJson(Map<String, dynamic> json) => _$ContextTestQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$ContextTestQuestionToJson(this);
}