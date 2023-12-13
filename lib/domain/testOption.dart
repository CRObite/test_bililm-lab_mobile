import 'package:json_annotation/json_annotation.dart';

import 'mediaFile.dart';

part 'testOption.g.dart';

@JsonSerializable()
class TestOption {
  int id;
  String text;
  List<MediaFile> mediaFiles;

  TestOption(this.id, this.text, this.mediaFiles);

  factory TestOption.fromJson(Map<String, dynamic> json) => _$TestOptionFromJson(json);
  Map<String, dynamic> toJson() => _$TestOptionToJson(this);
}