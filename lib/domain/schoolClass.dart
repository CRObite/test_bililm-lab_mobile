import 'package:json_annotation/json_annotation.dart';

part 'schoolClass.g.dart';

@JsonSerializable()

class SchoolClass {
  int id;
  String name;
  String testTimeLimit;
  String createdDate;
  int timeInMilliseconds;

  SchoolClass(this.id, this.name, this.testTimeLimit, this.createdDate,
      this.timeInMilliseconds);

  factory SchoolClass.fromJson(Map<String, dynamic> json) => _$SchoolClassFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolClassToJson(this);
}