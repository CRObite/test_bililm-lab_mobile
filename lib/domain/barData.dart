


import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';


part 'barData.g.dart';

@JsonSerializable()
class BarData{
  int? passedTestCount;
  int? lastTestScore;
  int? averageTestScore;
  ScoresData general;
  Map<String, ScoresData> subjects;


  BarData(this.passedTestCount, this.lastTestScore, this.averageTestScore,
      this.general, this.subjects);

  factory BarData.fromJson(Map<String, dynamic> json) => _$BarDataFromJson(json);
  Map<String, dynamic> toJson() => _$BarDataToJson(this);
}

