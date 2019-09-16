// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tendermint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TendermintResponse _$TendermintResponseFromJson(Map<String, dynamic> json) {
  return TendermintResponse(
    jsonRpc: json['jsonrpc'] as String,
    id: json['id'] as String,
    result: TendermintResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TendermintResponseToJson(TendermintResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonRpc,
      'id': instance.id,
      'result': instance.result,
    };
