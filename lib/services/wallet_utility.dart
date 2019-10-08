import 'dart:convert';
import 'dart:typed_data';

import 'package:bip39/bip39.dart' as Bip39;
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class WalletUtility {
  Wallet createWallet(String mnemonic, String password) {
    return CosmosWallet.fromMnemonic(
        mnemonic, Uint8List.fromList(utf8.encode(password)));
  }

  String createMnemonic() {
    return Bip39.generateMnemonic();
  }
}
