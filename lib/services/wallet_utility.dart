import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/scrypt_encrypted_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class WalletCrypto {
  Future<EncryptedWallet> encryptWallet(Wallet wallet, String password) async {
    final encrypted = await compute(_encryptedWallet, [wallet, password]);
    return encrypted;
  }

  Future<Wallet> decryptWallet(
      EncryptedWallet encrypted, String password) async {
    final wallet = await compute(_decryptWallet, [encrypted, password]);
    if (wallet == null) {
      throw ArgumentError(
          'Invalid password for wallet: ' + encrypted.toString());
    }
    return wallet;
  }

  static EncryptedWallet _encryptedWallet(List<dynamic> args) {
    return ScryptEncryptedWallet.fromWallet(args[0], args[1]);
  }

  static Wallet _decryptWallet(List<dynamic> args) {
    try {
      return args[0].unlock(args[1]);
    } on ArgumentError {
      return null;
    }
  }
}
