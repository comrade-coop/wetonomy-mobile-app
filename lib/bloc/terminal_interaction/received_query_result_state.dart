import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../../models/query.dart';
import 'terminal_interaction_state.dart';

part 'received_query_result_state.g.dart';

@immutable
@JsonSerializable(nullable: false)
class ReceivedQueryResultState extends TerminalInteractionState {
  final Map<String, dynamic> result;
  final Query query;

  ReceivedQueryResultState(this.result, this.query) : super([result, query]);

  factory ReceivedQueryResultState.fromJson(Map<String, dynamic> json) =>
      _$ReceivedQueryResultStateFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivedQueryResultStateToJson(this);

  String toEncodedJson() => jsonEncode(this.toJson());
}
