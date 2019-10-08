import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart' as pointyCastle;
import 'package:convert/convert.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:wetonomy/wallet/key_derivator.dart';
import 'package:wetonomy/wallet/random_bridge.dart';

class ScryptKeyDerivator implements KeyDerivator {
  final int dkLen;
  final int n;
  final int r;
  final int p;
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
    return ScryptKeyDerivator(32, 81892, 8, 1, salt);
  }

  @override
  Uint8List deriveKey(Uint8List password) {
    return _scrypt.process(password);
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'dKlen': dkLen,
      'n': n,
      'r': r,
      'p': p,
      'salt': hex.encode(salt),
    };
  }

  @override
  String get name => 'scrypt';
}
