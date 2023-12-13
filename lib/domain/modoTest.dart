
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/schoolClass.dart';
import 'package:test_bilimlab_project/domain/testCategory.dart';

part 'modoTest.g.dart';

@JsonSerializable()
class ModoTest{
  String id;
  String startedDate;
  String? passedDate;
  bool passed;
  SchoolClass schoolClass;
  Map<String, Map <String, TestCategory> > typeSubjectQuestionMap;

  ModoTest(this.id, this.startedDate, this.passedDate, this.passed,
      this.schoolClass, this.typeSubjectQuestionMap);

  factory ModoTest.fromJson(Map<String, dynamic> json) => _$ModoTestFromJson(json);
  Map<String, dynamic> toJson() => _$ModoTestToJson(this);
}


