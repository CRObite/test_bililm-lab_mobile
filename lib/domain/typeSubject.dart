
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/resultSubject.dart';

part 'typeSubject.g.dart';

@JsonSerializable()
class TypeSubject {
  String type;
  int score;
  List<ResultSubject> subjectsResult;
  bool isExpanded = false;

  TypeSubject(this.type, this.score, this.subjectsResult);

  factory TypeSubject.fromJson(Map<String, dynamic> json) => _$TypeSubjectFromJson(json);
  Map<String, dynamic> toJson() => _$TypeSubjectToJson(this);
}