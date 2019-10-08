import 'dart:typed_data';

abstract class KeyDerivator {
  String get name;

  Uint8List deriveKey(Uint8List password);

  Map<String, dynamic> encode();
}
