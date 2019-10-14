import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/converters/crypto_json_converter.dart';

import 'crypto.dart';

part 'encrypted_wallet_file.g.dart';

@immutable
@JsonSerializable(nullable: false)
class EncryptedWalletFile {
  @CryptoJsonConverter()
  final Crypto crypto;

  final String address;

  EncryptedWalletFile(this.crypto, this.address)
      : assert(crypto != null),
        assert(address != null);

  factory EncryptedWalletFile.fromJson(Map<String, dynamic> json) =>
      _$EncryptedWalletFileFromJson(json);

  Map<String, dynamic> toJson() => _$EncryptedWalletFileToJson(this);
}
