// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmos_tx_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosmosTxValue _$CosmosTxValueFromJson(Map<String, dynamic> json) {
  return CosmosTxValue(
    (json['msg'] as List)
        .map((e) => CosmosMsg.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['fee'] as Map<String, dynamic>,
    (json['signatures'] as List)
        .map((e) => Signatures.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['memo'] as String,
  );
}

Map<String, dynamic> _$CosmosTxValueToJson(CosmosTxValue instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'fee': instance.fee,
      'signatures': instance.signatures,
      'memo': instance.memo,
    };
