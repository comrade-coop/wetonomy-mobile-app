import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_action.g.dart';

@immutable
@JsonSerializable(nullable: false)
class ContractAction {
  final String target;
  final String actionName;
  final List<String> parameters;

  ContractAction(this.target, this.actionName, this.parameters);

  factory ContractAction.fromJson(Map<String, dynamic> json) =>
      _$ContractActionFromJson(json);

  Map<String, dynamic> toJson() => _$ContractActionToJson(this);
}
