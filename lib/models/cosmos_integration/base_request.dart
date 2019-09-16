import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable(nullable: false)
class BaseRequest {
  final String from;
  final String sequence;
  final String chain_id;
  final String account_number;
  BaseRequest(this.from, this.sequence, this.chain_id, this.account_number);
  factory BaseRequest.fromJson(Map<String, dynamic> json) => _$BaseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
}