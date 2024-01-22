import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/mediaFile.dart';
import 'package:test_bilimlab_project/domain/subOption.dart';
import 'package:test_bilimlab_project/domain/testOption.dart';



part 'testQuestion.g.dart';

@JsonSerializable()
class TestQuestion {
  int id;
  String question;
  bool multipleAnswers;
  List<int>? checkedAnswers;
  List<MediaFile> mediaFiles;
  List<TestOption> options;
  List<SubOption>? subOptions;
  String? recommendation;
  String? answeredType;
  String? type;


  TestQuestion(
      this.id,
      this.question,
      this.multipleAnswers,
      this.checkedAnswers,
      this.mediaFiles,
      this.options,
      this.subOptions,
      this.recommendation,
      this.answeredType,
      this.type);

  factory TestQuestion.fromJson(Map<String, dynamic> json) => _$TestQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$TestQuestionToJson(this);
}
