import 'package:bip39/bip39.dart' as Bip39;
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class WalletUtility {
  Wallet createWallet(String mnemonic) {
    return CosmosWallet.fromMnemonic(mnemonic);
  }

  String createMnemonic() {
    return Bip39.generateMnemonic();
  }
}
