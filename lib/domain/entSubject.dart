import 'package:json_annotation/json_annotation.dart';

part 'entSubject.g.dart';

@JsonSerializable()
class EntSubject {
  int id;
  String name;
  String contextType;

  EntSubject(this.id, this.name, this.contextType);

  factory EntSubject.fromJson(Map<String, dynamic> json) => _$EntSubjectFromJson(json);
  Map<String, dynamic> toJson() => _$EntSubjectToJson(this);
}