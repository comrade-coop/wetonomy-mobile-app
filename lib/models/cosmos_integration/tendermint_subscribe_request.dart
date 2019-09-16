import 'package:json_annotation/json_annotation.dart';

part 'tendermint_subscribe_request.g.dart';

@JsonSerializable(nullable: false)
class TendermintSubscribeRequest {
  final String jsonrpc;
  final String method;
  final String id;
  final Map<String, String> params;
  const TendermintSubscribeRequest(this.jsonrpc, this.method, this.id, this.params);
  factory TendermintSubscribeRequest.fromJson(Map<String, dynamic> json) => _$TendermintSubscribeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TendermintSubscribeRequestToJson(this);
}