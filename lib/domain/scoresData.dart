
import 'package:json_annotation/json_annotation.dart';

part 'scoresData.g.dart';

@JsonSerializable()
class ScoresData {
  List<String?> dates;
  List<int> scores;
  int maxScore;

  ScoresData(this.dates, this.scores, this.maxScore);

  factory ScoresData.fromJson(Map<String, dynamic> json) => _$ScoresDataFromJson(json);
  Map<String, dynamic> toJson() => _$ScoresDataToJson(this);

}