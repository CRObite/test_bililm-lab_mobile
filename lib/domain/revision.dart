import 'package:json_annotation/json_annotation.dart';
import 'package:test_bilimlab_project/domain/revisionItem.dart';

part 'revision.g.dart';

@JsonSerializable()

class Revision {
  int totalCount;
  int totalPages;
  List<RevisionItem> items;

  Revision(this.totalCount, this.totalPages, this.items);

  factory Revision.fromJson(Map<String, dynamic> json) => _$RevisionFromJson(json);
  Map<String, dynamic> toJson() => _$RevisionToJson(this);
}

