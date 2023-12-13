

import 'package:json_annotation/json_annotation.dart';

part 'resultSubject.g.dart';

@JsonSerializable()
class ResultSubject {
  String subjectName;
  int maxScore;
  int score;

  ResultSubject(this.subjectName, this.maxScore, this.score);

  factory ResultSubject.fromJson(Map<String, dynamic> json) => _$ResultSubjectFromJson(json);
  Map<String, dynamic> toJson() => _$ResultSubjectToJson(this);
}