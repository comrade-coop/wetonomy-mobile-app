// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionResult _$ActionResultFromJson(Map<String, dynamic> json) {
  return ActionResult(
    json['result'] as Map<String, dynamic>,
    Action.fromJson(json['action'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ActionResultToJson(ActionResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'action': instance.action,
    };
