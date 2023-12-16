


import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';


part 'barData.g.dart';

@JsonSerializable()
class BarData{
  ScoresData general;
  Map<String, ScoresData> subjects;

  BarData(this.general, this.subjects);

  factory BarData.fromJson(Map<String, dynamic> json) => _$BarDataFromJson(json);
  Map<String, dynamic> toJson() => _$BarDataToJson(this);
}

