// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmos_msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosmosMsg _$CosmosMsgFromJson(Map<String, dynamic> json) {
  return CosmosMsg(
    json['type'] as String,
    json['value'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CosmosMsgToJson(CosmosMsg instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
