import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/city.dart';
import 'package:test_bilimlab_project/domain/mediaFile.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';


part 'university.g.dart';

@JsonSerializable()
class University{
  int id;
  String name;
  String address;
  int middlePrice;
  String? status;
  bool militaryDepartment;
  bool dormitory;
  String description;
  String code;
  List<Specialization>? specializations;
  City city;
  List<MediaFile>? mediaFiles;

  University(
      this.id,
      this.name,
      this.address,
      this.middlePrice,
      this.status,
      this.militaryDepartment,
      this.dormitory,
      this.description,
      this.code,
      this.specializations,
      this.city,
      this.mediaFiles);


  factory University.fromJson(Map<String, dynamic> json) => _$UniversityFromJson(json);
  Map<String, dynamic> toJson() => _$UniversityToJson(this);
}



