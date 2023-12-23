import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';
import 'package:test_bilimlab_project/domain/totalResult.dart';


part 'revisionItem.g.dart';

@JsonSerializable()

class RevisionItem{
  int id;
  TestUser? testUser;
  TotalResult totalResult;
  List<String> subjects;
  String type;
  bool passed;
  String passedDate;

  RevisionItem(this.id, this.testUser, this.totalResult, this.subjects,
      this.type, this.passed, this.passedDate);

  factory RevisionItem.fromJson(Map<String, dynamic> json) => _$RevisionItemFromJson(json);
  Map<String, dynamic> toJson() => _$RevisionItemToJson(this);
}