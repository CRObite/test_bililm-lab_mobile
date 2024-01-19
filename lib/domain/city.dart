import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/region.dart';
import 'package:test_bilimlab_project/domain/school.dart';

part 'city.g.dart';

@JsonSerializable()
class City{
  int id;
  String name;
  Region region;
  List<School> schools;

  City(this.id, this.name, this.region, this.schools);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}

