import 'dart:math';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/export.dart' as pointyCastle;
import 'package:pointycastle/key_derivators/api.dart';
import 'package:wetonomy/models/converters/uint8_list_string_converter.dart';
import 'package:wetonomy/wallet/key_derivator.dart';
import 'package:wetonomy/wallet/random_bridge.dart';

part 'scrypt_key_derivator.g.dart';

@JsonSerializable(nullable: false)
class ScryptKeyDerivator implements KeyDerivator {
  static const String name = 'scrypt';

  @JsonKey(name: 'dklen')
  final int dkLen;
  final int n;
  final int r;
  final int p;

  @Uint8ListStringConverter()
  final Uint8List salt;

  pointyCastle.Scrypt _scrypt;

  ScryptKeyDerivator(this.dkLen, this.n, this.r, this.p, this.salt)
      : assert(dkLen != null),
        assert(n != null),
        assert(r != null),
        assert(p != null),
        assert(salt != null) {
    _scrypt = pointyCastle.Scrypt()
      ..init(ScryptParameters(n, r, p, dkLen, salt));
  }

  factory ScryptKeyDerivator.defaultParams() {
    final random = RandomBridge(Random.secure());
    final Uint8List salt = random.nextBytes(32);
    return ScryptKeyDerivator(32, 8192, 8, 1, salt);
  }

  factory ScryptKeyDerivator.fromJson(Map<String, dynamic> json) =>
      _$ScryptKeyDerivatorFromJson(json);

  @override
  Uint8List deriveKey(Uint8List password) {
    return _scrypt.process(password);
  }

  @override
  String get algorithmName => name;

  Map<String, dynamic> toJson() => _$ScryptKeyDerivatorToJson(this);

  @override
  Map<String, dynamic> get derivationParameters => toJson();
}
