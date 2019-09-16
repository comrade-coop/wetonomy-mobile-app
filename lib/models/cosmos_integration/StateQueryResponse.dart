import 'package:json_annotation/json_annotation.dart';

part 'StateQueryResponse.g.dart';

@JsonSerializable(nullable: false)
class StateQueryResponse {
  final String height;
  final Map<String, dynamic> result;
  StateQueryResponse({this.height, this.result});
  factory StateQueryResponse.fromJson(Map<String, dynamic> json) => _$StateQueryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StateQueryResponseToJson(this);
}