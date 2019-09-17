import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable(nullable: false)
class BaseRequest {
  final String from;
  final String sequence;
  @JsonKey(name: 'chain_id')
  final String chainId;
  @JsonKey(name: 'account_number')
  final String accountNumber;

  BaseRequest(this.from, this.sequence, this.chainId, this.accountNumber);

  factory BaseRequest.fromJson(Map<String, dynamic> json) =>
      _$BaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
}
