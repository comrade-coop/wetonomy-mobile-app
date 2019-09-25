import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@immutable
@JsonSerializable(nullable: false)
class Action extends Equatable {
  final List<String> targets;
  final String actionName;
  final Map<String, dynamic> parameters;

  Action(this.targets, this.actionName, this.parameters)
      : assert(targets != null),
        assert(actionName != null),
        assert(parameters != null),
        super([targets, actionName, parameters]);

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  factory Action.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return _$ActionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActionToJson(this);

  @override
  String toString() => toJson().toString();
}
