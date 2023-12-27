

import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/mediaFile.dart';



part 'subOption.g.dart';

@JsonSerializable()
class SubOption{

  int id;
  String text;
  List<MediaFile> mediaFiles;

  SubOption(this.id, this.text, this.mediaFiles);

  factory SubOption.fromJson(Map<String, dynamic> json) => _$SubOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubOptionToJson(this);

}