// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmos_tx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosmosTx _$CosmosTxFromJson(Map<String, dynamic> json) {
  return CosmosTx(
    json['type'] as String,
    CosmosTxValue.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CosmosTxToJson(CosmosTx instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
