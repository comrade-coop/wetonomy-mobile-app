import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_action.g.dart';

@immutable
@JsonSerializable(nullable: false)
class ContractAction extends Equatable {
  final String target;
  final String actionName;
  final List<String> parameters;

  ContractAction(this.target, this.actionName, this.parameters)
      : assert(target != null),
        assert(actionName != null),
        assert(parameters != null),
        super([target, actionName, parameters]);

  factory ContractAction.fromJson(Map<String, dynamic> json) =>
      _$ContractActionFromJson(json);

  factory ContractAction.fromJsonString(String jsonString) {
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return _$ContractActionFromJson(json);
    } on FormatException {
      throw new FormatException();
    }
  }

  Map<String, dynamic> toJson() => _$ContractActionToJson(this);
}
