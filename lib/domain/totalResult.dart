

import 'package:json_annotation/json_annotation.dart';

part 'totalResult.g.dart';

@JsonSerializable()
class TotalResult {
  int maxScore;
  int score;

  TotalResult(this.maxScore, this.score);

  factory TotalResult.fromJson(Map<String, dynamic> json) => _$TotalResultFromJson(json);
  Map<String, dynamic> toJson() => _$TotalResultToJson(this);
}