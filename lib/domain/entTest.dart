import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/testCategory.dart';


part 'entTest.g.dart';

@JsonSerializable()
class EntTest {
  String id;
  String startedDate;
  String? passedDate;
  bool passed;
  String type;
  Map<String, TestCategory> questionsMap;
  int? timeLimitInMilliseconds;


  EntTest(this.id, this.startedDate, this.passedDate, this.passed, this.type,
      this.questionsMap, this.timeLimitInMilliseconds);

  factory EntTest.fromJson(Map<String, dynamic> json) => _$EntTestFromJson(json);
  Map<String, dynamic> toJson() => _$EntTestToJson(this);
}