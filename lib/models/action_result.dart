import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'action.dart';

part 'action_result.g.dart';

@JsonSerializable(nullable: false)
class ActionResult extends Equatable {
  final Map<String, dynamic> result;
  final Action action;

  ActionResult(this.result, this.action)
      : assert(result != null),
        assert(action != null),
        super([result, action]);

  factory ActionResult.fromJson(Map<String, dynamic> json) =>
      _$ActionResultFromJson(json);

  factory ActionResult.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return _$ActionResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActionResultToJson(this);
}
