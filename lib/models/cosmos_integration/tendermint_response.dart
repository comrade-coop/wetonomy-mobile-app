import 'package:json_annotation/json_annotation.dart';
import './tendermint_result.dart';

part 'tendermint_response.g.dart';

@JsonSerializable(nullable: false)
class TendermintResponse {
  final String jsonrpc;
  final String id;
  final TendermintResult result;
  TendermintResponse({this.jsonrpc, this.id, this.result});
  factory TendermintResponse.fromJson(Map<String, dynamic> json) => _$TendermintResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TendermintResponseToJson(this);
}