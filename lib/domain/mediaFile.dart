import 'package:json_annotation/json_annotation.dart';

part 'mediaFile.g.dart';

@JsonSerializable()

class MediaFile {
  String id;
  String? name;
  String? originalName;
  String? extensions;
  String url;
  String? createdDate;

  MediaFile(this.id, this.name, this.originalName, this.extensions, this.url,
      this.createdDate);

  factory MediaFile.fromJson(Map<String, dynamic> json) => _$MediaFileFromJson(json);
  Map<String, dynamic> toJson() => _$MediaFileToJson(this);
}