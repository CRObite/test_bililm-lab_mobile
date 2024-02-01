import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';

part 'university.g.dart';

@JsonSerializable()
class University{

  int totalCount;
  int totalPages;
  List<UniversityItem> items;


  University(this.totalCount, this.totalPages, this.items);

  factory University.fromJson(Map<String, dynamic> json) => _$UniversityFromJson(json);
  Map<String, dynamic> toJson() => _$UniversityToJson(this);
}



