
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/resultSubject.dart';

part 'typeSubject.g.dart';

@JsonSerializable()
class TypeSubject {
  String type;
  int score;
  List<ResultSubject> subjectsResult;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isExpanded;


  TypeSubject(this.type, this.score, this.subjectsResult, {this.isExpanded = false});

  factory TypeSubject.fromJson(Map<String, dynamic> json) => _$TypeSubjectFromJson(json);
  Map<String, dynamic> toJson() => _$TypeSubjectToJson(this);
}