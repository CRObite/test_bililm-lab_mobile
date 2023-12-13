
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/testOption.dart';

import 'mediaFile.dart';

part 'schoolQuestion.g.dart';

@JsonSerializable()
class SchoolQuestion {
  int id;
  String question;
  bool multipleAnswers;
  List<int>? checkedAnswers;
  List<MediaFile> mediaFiles;
  List<TestOption> schoolOptions;


  SchoolQuestion(this.id, this.question, this.multipleAnswers,
      this.checkedAnswers, this.mediaFiles, this.schoolOptions);

  factory SchoolQuestion.fromJson(Map<String, dynamic> json) => _$SchoolQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolQuestionToJson(this);
}