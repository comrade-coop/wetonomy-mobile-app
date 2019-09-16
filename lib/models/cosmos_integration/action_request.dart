import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/cosmos_integration/base_request.dart';

part 'action_request.g.dart';

@JsonSerializable(nullable: false)
class ActionRequest {
  final BaseRequest base_req;
  final String name;
  final String action;
  ActionRequest(this.base_req, this.name, this.action);
  factory ActionRequest.fromJson(Map<String, dynamic> json) => _$ActionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ActionRequestToJson(this);
}


