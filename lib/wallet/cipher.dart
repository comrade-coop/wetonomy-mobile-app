import 'dart:typed_data';

import 'package:wetonomy/models/wallet/cipher_parameters.dart';

abstract class Cipher {
  String get algorithmName;

  CipherParameters get cipherParameters;

  Uint8List process(Uint8List data);
}
