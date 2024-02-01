
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/mediaFile.dart';

part 'postItem.g.dart';

@JsonSerializable()
class PostItem{
  int id;
  String? title;
  String? description;
  String? dateTime;
  MediaFile? mediaFiles;


  PostItem(
      this.id, this.title, this.description, this.dateTime, this.mediaFiles);

  factory PostItem.fromJson(Map<String, dynamic> json) => _$PostItemFromJson(json);
  Map<String, dynamic> toJson() => _$PostItemToJson(this);
}