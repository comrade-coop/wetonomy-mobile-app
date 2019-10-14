import 'dart:typed_data';

abstract class KeyDerivator {
  Uint8List deriveKey(Uint8List password);

  String get algorithmName;

  Map<String, dynamic> get derivationParameters;
}
