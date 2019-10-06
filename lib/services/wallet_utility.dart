import 'package:bip39/bip39.dart' as Bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:wetonomy/wallet/cosmos_hd_wallet.dart';

class WalletUtility {
  HDWallet createWallet(String mnemonic) {
    return CosmosHDWallet.fromMnemonic(mnemonic);
  }

  String createMnemonic() {
    return Bip39.generateMnemonic();
  }
}
