
import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/postItem.dart';

part 'post.g.dart';

@JsonSerializable()
class Post{
  int totalCount;
  int totalPages;
  List<PostItem> items;


  Post(this.totalCount, this.totalPages, this.items);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}