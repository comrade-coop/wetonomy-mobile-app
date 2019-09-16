import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../../models/query.dart';
import 'terminal_interaction_state.dart';

part 'terminal_interaction_state_after_query.g.dart';

@immutable
@JsonSerializable(nullable: false)
class TerminalInteractionStateAfterQuery extends TerminalInteractionState {
  final Map<String, dynamic> result;
  final Query query;
  TerminalInteractionStateAfterQuery(this.result, this.query);

  factory TerminalInteractionStateAfterQuery.fromJson(Map<String, dynamic> json) =>
      _$TerminalInteractionStateAfterQueryFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalInteractionStateAfterQueryToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}