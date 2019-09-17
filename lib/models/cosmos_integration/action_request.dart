import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/cosmos_integration/base_request.dart';

part 'action_request.g.dart';

@JsonSerializable(nullable: false)
class ActionRequest {
  @JsonKey(name: 'base_req')
  final BaseRequest baseRequest;
  final String name;
  final String action;

  ActionRequest(this.baseRequest, this.name, this.action);

  factory ActionRequest.fromJson(Map<String, dynamic> json) =>
      _$ActionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ActionRequestToJson(this);
}
