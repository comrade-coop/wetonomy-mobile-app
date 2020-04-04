import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';

// ignore: implementation_imports
import 'package:pointycastle/src/utils.dart' as pUtils;

/// Utility to use dart:math's Random class to generate numbers used by
/// pointycastle.
class RandomBridge implements SecureRandom {
  final Random _dartRandom;

  const RandomBridge(this._dartRandom) : assert(_dartRandom != null);

  @override
  String get algorithmName => 'DartRandom';

  @override
  BigInt nextBigInteger(int bitLength) {
    final fullBytes = bitLength ~/ 8;
    final remainingBits = bitLength % 8;

    final main = pUtils.decodeBigInt(nextBytes(fullBytes));
    final additional = _dartRandom.nextInt(1 << remainingBits);
    return main + (BigInt.from(additional) << (fullBytes * 8));
  }

  @override
  Uint8List nextBytes(int count) {
    final list = Uint8List(count);

    for (var i = 0; i < list.length; i++) {
      list[i] = nextUint8();
    }

    return list;
  }

  @override
  int nextUint16() => _dartRandom.nextInt(1 << 16);

  @override
  int nextUint32() => _dartRandom.nextInt(1 << 32);

  @override
  int nextUint8() => _dartRandom.nextInt(1 << 8);

  @override
  void seed(CipherParameters params) {
    // ignore, _random will already be seeded if wanted
  }
}
