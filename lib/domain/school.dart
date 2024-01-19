
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  int id;
  String name;
  bool? permissionForTest;
  bool? permissionForModo;
  String? city;

  School(this.id, this.name, this.permissionForTest, this.permissionForModo,
      this.city);

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}