// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractAction _$ContractActionFromJson(Map<String, dynamic> json) {
  return ContractAction(
    (json['targets'] as List).map((e) => e as String).toList(),
    json['actionName'] as String,
    json['parameters'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ContractActionToJson(ContractAction instance) =>
    <String, dynamic>{
      'Targets': instance.targets,
      'Type': instance.actionName,
      'Payload': instance.parameters,
    };
