// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryResult _$QueryResultFromJson(Map<String, dynamic> json) {
  return QueryResult(
    json['result'] as Map<String, dynamic>,
    Query.fromJson(json['query'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QueryResultToJson(QueryResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'query': instance.query,
    };
