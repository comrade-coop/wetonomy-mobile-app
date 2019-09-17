// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest _$BaseRequestFromJson(Map<String, dynamic> json) {
  return BaseRequest(
    json['from'] as String,
    json['sequence'] as String,
    json['chain_id'] as String,
    json['account_number'] as String,
  );
}

Map<String, dynamic> _$BaseRequestToJson(BaseRequest instance) =>
    <String, dynamic>{
      'from': instance.from,
      'sequence': instance.sequence,
      'chain_id': instance.chainId,
      'account_number': instance.accountNumber,
    };
