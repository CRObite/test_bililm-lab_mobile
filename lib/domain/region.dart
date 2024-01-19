import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/city.dart';

part 'region.g.dart';

@JsonSerializable()
class Region {
  int id;
  String name;
  List<City>? cities;

  Region(this.id, this.name, this.cities);

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}



