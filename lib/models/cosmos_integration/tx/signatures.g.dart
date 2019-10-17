// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signatures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signatures _$SignaturesFromJson(Map<String, dynamic> json) {
  return Signatures(
    json['pub_key'] as Map<String, dynamic>,
    json['signature'] as String,
  );
}

Map<String, dynamic> _$SignaturesToJson(Signatures instance) =>
    <String, dynamic>{
      'pub_key': instance.pub_key,
      'signature': instance.signature,
    };
