import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'query.dart';

part 'query_result.g.dart';

@JsonSerializable(nullable: false)
class QueryResult extends Equatable {
  final Map<String, dynamic> data;
  final Query query;

  QueryResult(this.data, this.query)
      : assert(data != null),
        assert(query != null),
        super([data, Query]);

  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);

  factory QueryResult.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return _$QueryResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QueryResultToJson(this);
}
