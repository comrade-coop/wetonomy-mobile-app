// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_interaction_state_after_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalInteractionStateAfterQuery _$TerminalInteractionStateAfterQueryFromJson(
    Map<String, dynamic> json) {
  return TerminalInteractionStateAfterQuery(
    json['result'] as Map<String, dynamic>,
    Query.fromJson(json['query'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TerminalInteractionStateAfterQueryToJson(
        TerminalInteractionStateAfterQuery instance) =>
    <String, dynamic>{
      'result': instance.result,
      'query': instance.query,
    };
