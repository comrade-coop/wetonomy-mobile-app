import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart' as pCastle;
import 'package:wetonomy/models/wallet/cipher_parameters.dart';
import 'package:wetonomy/models/wallet/crypto.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/key_derivator.dart';
import 'package:wetonomy/wallet/random_bridge.dart';
import 'package:wetonomy/wallet/scrypt_key_derivator.dart';
import 'package:wetonomy/wallet/wallet.dart';

class CosmosEncryptedWallet implements EncryptedWallet {
  final Crypto crypto;
  final KeyDerivator _keyDerivator = ScryptKeyDerivator.defaultParams();

  final String address;

  static const String aesAlgorithmName = 'aes-128-ctr';

  CosmosEncryptedWallet._(this.crypto, this.address)
      : assert(crypto != null),
        assert(address != null);

  factory CosmosEncryptedWallet.fromWallet(Wallet wallet, String password) {
    final Uint8List iv = _generateInitialVector();
    final derivator = ScryptKeyDerivator.defaultParams();

    final Uint8List encodedPassword = utf8.encode(password);
    final Uint8List cipher =
        _encryptWallet(derivator, wallet, encodedPassword, iv);
    final Uint8List mac =
        _generateMac(derivator.deriveKey(encodedPassword), cipher);

    final crypto = Crypto(cipher, mac, aesAlgorithmName, CipherParameters(iv),
        derivator.toJson());

    return CosmosEncryptedWallet._(crypto, wallet.address);
  }

  factory CosmosEncryptedWallet.fromEncryptedWalletFile(
      EncryptedWalletFile file) {
    return CosmosEncryptedWallet._(file.crypto, file.address);
  }

  Wallet unlock(String password) {
    if (crypto.cipher != aesAlgorithmName) {
      throw ArgumentError(
          'Wallet file uses ${crypto.cipher} as cipher, but only $aesAlgorithmName is supported.');
    }

    final Uint8List encodedPassword = Uint8List.fromList(utf8.encode(password));
    final Uint8List derivedKey = _keyDerivator.deriveKey(encodedPassword);
    final aesKey = Uint8List.view(derivedKey.buffer, 0, 16);

    final Uint8List derivedMac = _generateMac(derivedKey, crypto.cipherText);

    if (!listEquals(derivedMac, crypto.mac)) {
      throw ArgumentError(
          'Could not unlock wallet file. You either supplied the wrong password or the file is corrupted');
    }

    final Uint8List iv = crypto.cipherParameters.initialVector;
    final pCastle.CTRStreamCipher aes = _initCipher(aesKey, iv);
    final Uint8List base58 = aes.process(Uint8List.fromList(crypto.cipherText));
    return CosmosWallet.fromBase58(utf8.decode(base58));
  }

  static Uint8List _generateMac(List<int> derivedKey, List<int> cipherText) {
    final List<int> macBody = <int>[]
      ..addAll(derivedKey.sublist(16, 32))
      ..addAll(cipherText);
    return pCastle.SHA3Digest(256).process(Uint8List.fromList(macBody));
  }

  static pCastle.CTRStreamCipher _initCipher(Uint8List aesKey, Uint8List iv) {
    return pCastle.CTRStreamCipher(pCastle.AESFastEngine())
      ..init(false, pCastle.ParametersWithIV(pCastle.KeyParameter(aesKey), iv));
  }

  static Uint8List _encryptWallet(KeyDerivator derivator, Wallet wallet,
      Uint8List password, Uint8List aesInitialVector) {
    final Uint8List derived = derivator.deriveKey(password);
    final Uint8List aesKey = Uint8List.view(derived.buffer, 0, 16);

    final pCastle.CTRStreamCipher aes = _initCipher(aesKey, aesInitialVector);
    return aes.process(Uint8List.fromList(utf8.encode(wallet.toBase58())));
  }

  static Uint8List _generateInitialVector() {
    final random = RandomBridge(Random.secure());
    return random.nextBytes(16);
  }

  EncryptedWalletFile toEncryptedWalletFile() {
    return EncryptedWalletFile(crypto, address);
  }
}
