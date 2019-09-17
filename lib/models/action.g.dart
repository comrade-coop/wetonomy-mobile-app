// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) {
  return Action(
    (json['targets'] as List).map((e) => e as String).toList(),
    json['actionName'] as String,
    json['parameters'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ActionToJson(Action instance) =>
    <String, dynamic>{
      'Targets': instance.targets,
      'Type': instance.actionName,
      'Payload': instance.parameters,
    };
