import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/schoolQuestion.dart';
import 'package:test_bilimlab_project/domain/contextTestQuestion.dart';
import 'package:test_bilimlab_project/domain/testQuestion.dart';


part 'testCategory.g.dart';

@JsonSerializable()
class TestCategory {
  List<TestQuestion>? questions;
  List<ContextTestQuestion>? contextQuestions;
  List<TestQuestion>? multipleQuestions;
  List<SchoolQuestion>? schoolQuestions;
  List<SchoolQuestion>? schoolMultipleQuestions;
  List<TestQuestion>? comparisonQuestions;


  TestCategory(
      this.questions,
      this.contextQuestions,
      this.multipleQuestions,
      this.schoolQuestions,
      this.schoolMultipleQuestions,
      this.comparisonQuestions);

  @JsonKey(includeFromJson: false, includeToJson: false)
  int startedIndex = 0;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool itsFirstTime = true;

  List<TestQuestion> getAllQuestions() {
    List<TestQuestion> allQuestions = [];
    allQuestions.addAll(questions ?? []);
    allQuestions.addAll(multipleQuestions ?? []);
    allQuestions.addAll(comparisonQuestions ?? []);

    for (ContextTestQuestion? contextQuestion in contextQuestions ?? []) {
      if (contextQuestion?.questions != null) {
        for (TestQuestion question in contextQuestion!.questions!) {
          allQuestions.add(question);

          if (itsFirstTime) {
            startedIndex = allQuestions.length - 1;
            itsFirstTime = false;
          }
        }
      }
    }
    return allQuestions;
  }

  List<SchoolQuestion> getAllSchoolQuestions() {
    List<SchoolQuestion> allQuestions = [];
    allQuestions.addAll(schoolQuestions ?? []);
    allQuestions.addAll(schoolMultipleQuestions ?? []);

    for (ContextTestQuestion contextQuestion in contextQuestions ?? []) {
      if (contextQuestion.schoolQuestions != null) {
        for(SchoolQuestion question in contextQuestion.schoolQuestions!){
          allQuestions.add(question);

          if(itsFirstTime){
            startedIndex = allQuestions.length - 1;
            itsFirstTime = false;
          }

        }
      }

    }
    return allQuestions;
  }

  List<String> getAllContextContents() {
    List<String> allContents = [];
    for (ContextTestQuestion contextQuestion in contextQuestions ?? []) {
      allContents.add(contextQuestion.content);
    }
    return allContents;
  }

  List<int> getLengthsOfContextQuestions() {
    List<int> lengths = [];
    for (ContextTestQuestion contextQuestion in contextQuestions ?? []) {
      lengths.add(contextQuestion.questions!.length);
    }
    return lengths;
  }

  List<int> getLengthsOfContextSchoolQuestions() {
    List<int> lengths = [];
    for (ContextTestQuestion contextQuestion in contextQuestions ?? []) {
      lengths.add(contextQuestion.schoolQuestions!.length);
    }
    return lengths;
  }

  int getStartedContextQuestionsIndex(){
    return startedIndex;
  }

  factory TestCategory.fromJson(Map<String, dynamic> json) => _$TestCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$TestCategoryToJson(this);

}
