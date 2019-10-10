import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'crypto.dart';

@immutable
@JsonSerializable(nullable: false)
class EncryptedWalletFile {
  final Crypto crypto;
  final String address;

  EncryptedWalletFile(this.crypto, this.address)
      : assert(crypto != null),
        assert(address != null);

  factory EncryptedWalletFile.fromJson(Map<String, dynamic> json) => null;

  Map<String, dynamic> toJson() => null;
}
