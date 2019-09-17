// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tendermint_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TendermintResult _$TendermintResultFromJson(Map<String, dynamic> json) {
  return TendermintResult(
    query: json['query'] as String,
    data: json['data'] as Map<String, dynamic>,
    events: json['events'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$TendermintResultToJson(TendermintResult instance) =>
    <String, dynamic>{
      'query': instance.query,
      'data': instance.data,
      'events': instance.events,
    };
