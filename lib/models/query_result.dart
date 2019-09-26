import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'query.dart';

part 'query_result.g.dart';

@JsonSerializable(nullable: false)
class QueryResult extends Equatable {
  final Map<String, dynamic> result;
  final Query query;

  QueryResult(this.result, this.query)
      : assert(result != null),
        assert(query != null),
        super([result, Query]);

  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);

  factory QueryResult.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return _$QueryResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QueryResultToJson(this);
}
