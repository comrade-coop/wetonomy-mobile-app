import 'dart:typed_data';

abstract class Wallet {
  Uint8List get privateKey;

  Uint8List get publicKey;

  String get address;

  Wallet derive(int index);

  Wallet derivePath(String path);

  Uint8List sign(String message);

  bool verify(String message, Uint8List signature);
}
