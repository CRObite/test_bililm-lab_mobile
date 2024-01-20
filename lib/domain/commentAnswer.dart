

import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
part 'commentAnswer.g.dart';

@JsonSerializable()
class CommentAnswer{
  int id;
  String text;
  String dateTime;
  Comment comment;
  TestUser appUser;

  CommentAnswer(this.id, this.text, this.dateTime, this.comment, this.appUser);

  factory CommentAnswer.fromJson(Map<String, dynamic> json) => _$CommentAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$CommentAnswerToJson(this);
}