import 'package:bip39/bip39.dart' as Bip39;
import 'package:flutter/foundation.dart';
import 'package:wetonomy/wallet/cosmos_encrypted_wallet.dart';
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
    final encrypted = await compute(_encryptWallet, [wallet, password]);
    return encrypted;
  }

  static EncryptedWallet _encryptWallet(List<dynamic> args) {
    return CosmosEncryptedWallet.fromWallet(args[0], args[1]);
  }
}
