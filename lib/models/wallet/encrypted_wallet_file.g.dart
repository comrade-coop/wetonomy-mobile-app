// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_wallet_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncryptedWalletFile _$EncryptedWalletFileFromJson(Map<String, dynamic> json) {
  return EncryptedWalletFile(
    const CryptoJsonConverter()
        .fromJson(json['crypto'] as Map<String, dynamic>),
    json['address'] as String,
  );
}

Map<String, dynamic> _$EncryptedWalletFileToJson(
        EncryptedWalletFile instance) =>
    <String, dynamic>{
      'crypto': const CryptoJsonConverter().toJson(instance.crypto),
      'address': instance.address,
    };
