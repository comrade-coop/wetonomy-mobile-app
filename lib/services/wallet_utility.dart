import 'package:bip39/bip39.dart' as Bip39;
import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/scrypt_encrypted_wallet.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class WalletUtility {
  Wallet createWallet(String mnemonic) {
    return CosmosWallet.fromMnemonic(mnemonic);
  }

  String createMnemonic() {
    return Bip39.generateMnemonic();
  }

  Future<EncryptedWallet> encryptWallet(Wallet wallet, String password) async {
    final encrypted = await compute(_encryptedWallet, [wallet, password]);
    return encrypted;
  }

  Future<Wallet> tryUnlockWallet(EncryptedWallet encrypted,
      String password) async {
    final wallet = await compute(_decryptWallet, [encrypted, password]);
    return wallet;
  }

  static EncryptedWallet _encryptedWallet(List<dynamic> args) {
    return ScryptEncryptedWallet.fromWallet(args[0], args[1]);
  }

  static Wallet _decryptWallet(List<dynamic> args) {
    return args[0].unlock(args[1]);
  }
}
