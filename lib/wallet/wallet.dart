import 'dart:typed_data';

abstract class Wallet {
  Uint8List get privateKey;

  Uint8List get publicKey;

  String get address;

  Uint8List get iv;

  Uint8List get password;

  String toBase58();

  Wallet derive(int index);

  Uint8List sign(String message);

  bool verify(String message, Uint8List signature);

  String toJson();
}
