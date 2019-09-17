// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tendermint_subscribe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TendermintSubscribeRequest _$TendermintSubscribeRequestFromJson(
    Map<String, dynamic> json) {
  return TendermintSubscribeRequest(
    json['jsonrpc'] as String,
    json['method'] as String,
    json['id'] as String,
    Map<String, String>.from(json['params'] as Map),
  );
}

Map<String, dynamic> _$TendermintSubscribeRequestToJson(
        TendermintSubscribeRequest instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonRpc,
      'method': instance.method,
      'id': instance.id,
      'params': instance.params,
    };
