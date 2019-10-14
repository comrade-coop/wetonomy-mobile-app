import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/wallet/cipher_parameters.dart';
import 'package:wetonomy/models/uint8_list_string_converter.dart';

part 'crypto.g.dart';

@JsonSerializable(nullable: false)
class Crypto {
  @JsonKey(name: 'kdf')
  String keyDerivationFunction;

  @JsonKey(name: 'ciphertext')
  @Uint8ListStringConverter()
  final Uint8List cipherText;

  @JsonKey(name: 'mac')
  @Uint8ListStringConverter()
  final Uint8List mac;

  final String cipher;

  @JsonKey(name: 'cipherparams')
  final CipherParameters cipherParameters;

  @JsonKey(name: 'kdfparams')
  final Map<String, dynamic> keyDerivationParams;

  Crypto(this.cipherText, this.mac, this.cipher, this.cipherParameters,
      this.keyDerivationParams)
      : assert(cipherText != null),
        assert(mac != null),
        assert(cipher != null),
        assert(cipherParameters != null),
        assert(keyDerivationParams != null);

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}
