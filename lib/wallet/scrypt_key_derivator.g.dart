// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrypt_key_derivator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScryptKeyDerivator _$ScryptKeyDerivatorFromJson(Map<String, dynamic> json) {
  return ScryptKeyDerivator(
    json['dklen'] as int,
    json['n'] as int,
    json['r'] as int,
    json['p'] as int,
    const Uint8ListStringConverter().fromJson(json['salt'] as String),
  );
}

Map<String, dynamic> _$ScryptKeyDerivatorToJson(ScryptKeyDerivator instance) =>
    <String, dynamic>{
      'dklen': instance.dkLen,
      'n': instance.n,
      'r': instance.r,
      'p': instance.p,
      'salt': const Uint8ListStringConverter().toJson(instance.salt),
    };
