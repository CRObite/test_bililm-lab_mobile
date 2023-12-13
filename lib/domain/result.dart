import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/resultSubject.dart';
import 'package:test_bilimlab_project/domain/totalResult.dart';

part 'result.g.dart';

@JsonSerializable()
class Result{
  TotalResult totalResult;
  List<ResultSubject> subjectsResult;

  Result(this.totalResult, this.subjectsResult);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}