import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';

@immutable
@JsonSerializable(nullable: false)
class Query {
  @JsonKey(name: 'Url')
  final String url;

  Query(this.url);

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  factory Query.fromJsonString(String jsonString) {
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return _$QueryFromJson(json);
    } on FormatException {
      throw new FormatException();
    }
  }

  Map<String, dynamic> toJson() => _$QueryToJson(this);

  @override
  String toString() => toJson().toString();
}
