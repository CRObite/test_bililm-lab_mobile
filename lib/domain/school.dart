
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  int id;
  String name;
  bool? permissionForTest;
  bool? permissionForModo;

  School(this.id, this.name, this.permissionForTest, this.permissionForModo);

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}