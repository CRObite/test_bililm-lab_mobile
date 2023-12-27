import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/subOption.dart';

import 'mediaFile.dart';

part 'testOption.g.dart';

@JsonSerializable()
class TestOption {
  int id;
  String text;
  bool? isRight;
  SubOption? subOption;
  List<MediaFile> mediaFiles;


  TestOption(this.id, this.text, this.isRight, this.subOption, this.mediaFiles);

  factory TestOption.fromJson(Map<String, dynamic> json) => _$TestOptionFromJson(json);
  Map<String, dynamic> toJson() => _$TestOptionToJson(this);
}