import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart' as pCastle;
import 'package:wetonomy/models/wallet/cipher_parameters.dart';
import 'package:wetonomy/wallet/cipher.dart';
import 'package:wetonomy/wallet/random_bridge.dart';

class AesCipher implements Cipher {
  static const String name = 'aes-128-ctr';

  final CipherParameters cipherParameters;
  pCastle.CTRStreamCipher _cipher;

  AesCipher(Uint8List key, this.cipherParameters)
      : assert(cipherParameters != null) {
    _cipher = pCastle.CTRStreamCipher(pCastle.AESFastEngine())
      ..init(
          false,
          pCastle.ParametersWithIV(
              pCastle.KeyParameter(key), cipherParameters.initialVector));
  }

  factory AesCipher.generateIV(Uint8List key) {
    final Uint8List iv = _generateInitialVector();
    return AesCipher(key, CipherParameters(iv));
  }

  @override
  String get algorithmName => name;

  @override
  Uint8List process(Uint8List data) {
    return _cipher.process(data);
  }

  static Uint8List _generateInitialVector() {
    final random = RandomBridge(Random.secure());
    return random.nextBytes(16);
  }
}
