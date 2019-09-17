// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_query_result_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivedQueryResultState _$ReceivedQueryResultStateFromJson(
    Map<String, dynamic> json) {
  return ReceivedQueryResultState(
    json['result'] as Map<String, dynamic>,
    Query.fromJson(json['query'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceivedQueryResultStateToJson(
        ReceivedQueryResultState instance) =>
    <String, dynamic>{
      'result': instance.result,
      'query': instance.query,
    };
