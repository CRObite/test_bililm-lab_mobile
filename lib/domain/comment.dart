import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/post.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
import 'package:test_bilimlab_project/domain/university.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment{
  int id;
  String text;
  String type;
  String dateTime;
  Post? post;
  University? university;
  Specialization? specialization;
  TestUser appUser;

  Comment(this.id, this.text, this.type, this.dateTime, this.post,
      this.university, this.specialization, this.appUser);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}