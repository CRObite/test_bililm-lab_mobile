
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/totalResult.dart';
import 'package:test_bilimlab_project/domain/typeSubject.dart';

part 'modoResult.g.dart';

@JsonSerializable()

class ModoResult {
  TotalResult totalResult;
  List<TypeSubject> typeSubjects;

  ModoResult(this.totalResult, this.typeSubjects);


  factory ModoResult.fromJson(Map<String, dynamic> json) => _$ModoResultFromJson(json);
  Map<String, dynamic> toJson() => _$ModoResultToJson(this);

}

