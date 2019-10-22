import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart' as pCastle;
import 'package:wetonomy/models/wallet/cipher_parameters.dart';
import 'package:wetonomy/models/wallet/crypto.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/aes_cipher.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/key_derivator.dart';
import 'package:wetonomy/wallet/scrypt_key_derivator.dart';
import 'package:wetonomy/wallet/wallet.dart';

class ScryptEncryptedWallet implements EncryptedWallet {
  final KeyDerivator _keyDerivator;

  final Uint8List _encryptedWallet;
  final Uint8List _mac;
  final String address;
  final CipherParameters _cipherParameters;

  ScryptEncryptedWallet._(this.address, this._keyDerivator,
      this._encryptedWallet, this._mac, this._cipherParameters)
      : assert(address != null),
        assert(_keyDerivator != null),
        assert(_encryptedWallet != null),
        assert(_mac != null),
        assert(_cipherParameters != null);

  factory ScryptEncryptedWallet.fromWallet(Wallet wallet, String password) {
    final derivator = ScryptKeyDerivator.defaultParams();

    final Uint8List encodedPassword = utf8.encode(password);
    final Uint8List derived = derivator.deriveKey(encodedPassword);
    final Uint8List aesKey = Uint8List.view(derived.buffer, 0, 16);

    final aes = AesCipher.generateIV(aesKey);
    final cipher = aes.process(utf8.encode(wallet.toBase58()));

    final Uint8List mac = _generateMac(derived, cipher);

    return ScryptEncryptedWallet._(
        wallet.address, derivator, cipher, mac, aes.cipherParameters);
  }

  factory ScryptEncryptedWallet.fromEncryptedWalletFile(
      EncryptedWalletFile file) {
    if (file.crypto.cipher != AesCipher.name) {
      throw ArgumentError(
          'Wallet file uses ${file.crypto.cipher} as cipher, but only ${AesCipher.name} is supported.');
    }

    if (file.crypto.keyDerivationFunction != ScryptKeyDerivator.name) {
      throw ArgumentError(
          'Wallet file uses ${file.crypto.keyDerivationFunction} as a key derivation function, but only ${ScryptKeyDerivator.name} is supported.');
    }

    final derivator =
        ScryptKeyDerivator.fromJson(file.crypto.keyDerivationParams);

    return ScryptEncryptedWallet._(file.address, derivator,
        file.crypto.cipherText, file.crypto.mac, file.crypto.cipherParameters);
  }

  Wallet unlock(String password) {
    final Uint8List encodedPassword = utf8.encode(password);
    final Uint8List derivedKey = _keyDerivator.deriveKey(encodedPassword);
    final aesKey = Uint8List.view(derivedKey.buffer, 0, 16);

    final Uint8List derivedMac = _generateMac(derivedKey, _encryptedWallet);

    if (!listEquals(derivedMac, _mac)) {
      throw ArgumentError(
          'Could not unlock wallet file. You either supplied the wrong password or the file is corrupted');
    }

    final cipher = AesCipher(aesKey, _cipherParameters);
    final Uint8List base58 =
        cipher.process(Uint8List.fromList(_encryptedWallet));
    return CosmosWallet.fromBase58(utf8.decode(base58));
  }

  static Uint8List _generateMac(List<int> derivedKey, List<int> cipherText) {
    final List<int> macBody = <int>[]
      ..addAll(derivedKey.sublist(16, 32))
      ..addAll(cipherText);
    return pCastle.SHA3Digest(256).process(Uint8List.fromList(macBody));
  }

  EncryptedWalletFile toEncryptedWalletFile() {
    final crypto = Crypto(_keyDerivator.algorithmName, _encryptedWallet, _mac,
        AesCipher.name, _cipherParameters, _keyDerivator.derivationParameters);
    return EncryptedWalletFile(crypto, address);
  }
}
