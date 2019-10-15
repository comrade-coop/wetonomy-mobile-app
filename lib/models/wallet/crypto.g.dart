// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crypto _$CryptoFromJson(Map<String, dynamic> json) {
  return Crypto(
    json['kdf'] as String,
    const Uint8ListStringConverter().fromJson(json['ciphertext'] as String),
    const Uint8ListStringConverter().fromJson(json['mac'] as String),
    json['cipher'] as String,
    const CipherParametersJsonConverter()
        .fromJson(json['cipherparams'] as Map<String, dynamic>),
    json['kdfparams'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CryptoToJson(Crypto instance) => <String, dynamic>{
      'kdf': instance.keyDerivationFunction,
      'ciphertext':
          const Uint8ListStringConverter().toJson(instance.cipherText),
      'mac': const Uint8ListStringConverter().toJson(instance.mac),
      'cipher': instance.cipher,
      'cipherparams': const CipherParametersJsonConverter()
          .toJson(instance.cipherParameters),
      'kdfparams': instance.keyDerivationParams,
    };
