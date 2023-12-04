

import 'package:json_annotation/json_annotation.dart';

part 'modoClass.g.dart';

@JsonSerializable()
class ModoClass {
  int id;
  String name;

  ModoClass(this.id, this.name);


  factory ModoClass.fromJson(Map<String, dynamic> json) => _$ModoClassFromJson(json);
  Map<String, dynamic> toJson() => _$ModoClassToJson(this);

}