import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/resultSubject.dart';
import 'package:test_bilimlab_project/domain/totalResult.dart';

part 'entResult.g.dart';

@JsonSerializable()
class EntResult{
  TotalResult totalResult;
  List<ResultSubject> subjectsResult;

  EntResult(this.totalResult, this.subjectsResult);

  factory EntResult.fromJson(Map<String, dynamic> json) => _$EntResultFromJson(json);
  Map<String, dynamic> toJson() => _$EntResultToJson(this);
}