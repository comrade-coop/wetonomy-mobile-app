// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractAction _$ContractActionFromJson(Map<String, dynamic> json) {
  return ContractAction(
    json['target'] as String,
    json['actionName'] as String,
    (json['parameters'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ContractActionToJson(ContractAction instance) =>
    <String, dynamic>{
      'target': instance.target,
      'actionName': instance.actionName,
      'parameters': instance.parameters,
    };
