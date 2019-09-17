// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionRequest _$ActionRequestFromJson(Map<String, dynamic> json) {
  return ActionRequest(
    BaseRequest.fromJson(json['base_req'] as Map<String, dynamic>),
    json['name'] as String,
    json['action'] as String,
  );
}

Map<String, dynamic> _$ActionRequestToJson(ActionRequest instance) =>
    <String, dynamic>{
      'base_req': instance.baseRequest,
      'name': instance.name,
      'action': instance.action,
    };
