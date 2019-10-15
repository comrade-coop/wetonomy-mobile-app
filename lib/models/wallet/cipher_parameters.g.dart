// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cipher_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CipherParameters _$CipherParametersFromJson(Map<String, dynamic> json) {
  return CipherParameters(
    const Uint8ListStringConverter().fromJson(json['iv'] as String),
  );
}

Map<String, dynamic> _$CipherParametersToJson(CipherParameters instance) =>
    <String, dynamic>{
      'iv': const Uint8ListStringConverter().toJson(instance.initialVector),
    };
