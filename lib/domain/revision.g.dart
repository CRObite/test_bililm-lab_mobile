// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Revision _$RevisionFromJson(Map<String, dynamic> json) => Revision(
      json['totalCount'] as int,
      json['totalPages'] as int,
      (json['items'] as List<dynamic>)
          .map((e) => RevisionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RevisionToJson(Revision instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
