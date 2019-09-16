import 'package:json_annotation/json_annotation.dart';

part 'tendermint_result.g.dart';

@JsonSerializable(nullable: false)
class TendermintResult {
  final String query;
  final Map<String, dynamic> data;
  final Map<String, dynamic> events;
  TendermintResult({this.query, this.data, this.events});
  factory TendermintResult.fromJson(Map<String, dynamic> json) => _$TendermintResultFromJson(json);
  Map<String, dynamic> toJson() => _$TendermintResultToJson(this);
}