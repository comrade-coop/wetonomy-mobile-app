// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) {
  return Contract(
    json['address'] as String,
    json['state'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'address': instance.address,
      'state': instance.state,
    };
