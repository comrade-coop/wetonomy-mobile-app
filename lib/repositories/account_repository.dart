import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:wetonomy/services/wallet_utils.dart';

class AccountRepository {
  final WalletUtility _walletUtil;

  AccountRepository(this._walletUtil) : assert(_walletUtil != null);

  HDWallet createWallet(String mnemonic) {
    return _walletUtil.createWallet(mnemonic);
  }

  String createMnemonic() {
    return _walletUtil.generateMnemonic();
  }

  HDWallet createAndPersistAccount(String mnemonic) {
    HDWallet wallet = createWallet(mnemonic);
    persistWallet(wallet);
    return wallet;
  }

  void persistWallet(HDWallet wallet) {
    // TODO: Add wallet persistence
  }
}
