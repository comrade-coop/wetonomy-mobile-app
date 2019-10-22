import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:wetonomy/models/wallet/cipher_parameters.dart';
import 'package:wetonomy/models/converters/uint8_list_string_converter.dart';
import 'package:wetonomy/models/converters/cipher_parameters_json_converter.dart';

part 'crypto.g.dart';

@JsonSerializable(nullable: false)
class Crypto {
  @JsonKey(name: 'kdf')
  final String keyDerivationFunction;

  @JsonKey(name: 'ciphertext')
  @Uint8ListStringConverter()
  final Uint8List cipherText;

  @JsonKey(name: 'mac')
  @Uint8ListStringConverter()
  final Uint8List mac;

  final String cipher;

  @JsonKey(name: 'cipherparams')
  @CipherParametersJsonConverter()
  final CipherParameters cipherParameters;

  @JsonKey(name: 'kdfparams')
  final Map<String, dynamic> keyDerivationParams;

  Crypto(this.keyDerivationFunction, this.cipherText, this.mac, this.cipher,
      this.cipherParameters, this.keyDerivationParams);

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}
