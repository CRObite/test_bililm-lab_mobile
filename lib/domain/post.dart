
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/mediaFile.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';


part 'post.g.dart';

@JsonSerializable()
class Post{
  int id;
  String title;
  String? description;
  String? dateTime;
  List<MediaFile>? mediaFiles;
  TestUser? appUser;

  Post(this.id, this.title, this.description, this.dateTime, this.mediaFiles,
      this.appUser);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}