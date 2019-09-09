// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractsState _$ContractsStateFromJson(Map<String, dynamic> json) {
  return ContractsState(
    (json['contracts'] as List)
        .map((e) => Contract.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ContractsStateToJson(ContractsState instance) =>
    <String, dynamic>{
      'contracts': instance.contracts,
    };
