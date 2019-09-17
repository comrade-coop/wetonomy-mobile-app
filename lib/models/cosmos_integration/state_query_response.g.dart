// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_query_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateQueryResponse _$StateQueryResponseFromJson(Map<String, dynamic> json) {
  return StateQueryResponse(
    height: json['height'] as String,
    result: json['result'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$StateQueryResponseToJson(StateQueryResponse instance) =>
    <String, dynamic>{
      'height': instance.height,
      'result': instance.result,
    };
