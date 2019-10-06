import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/services/wallet_utility.dart';

class AccountRepository {
  final WalletUtility _walletUtil;
  final WalletStorage _walletStorage;

  AccountRepository(this._walletUtil, this._walletStorage)
      : assert(_walletUtil != null),
        assert(_walletStorage != null);

  HDWallet createWallet(String mnemonic) {
    if (mnemonic == null) {
      throw ArgumentError.notNull('mnemonic');
    }
    return _walletUtil.createWallet(mnemonic);
  }

  String createMnemonic() {
    return _walletUtil.createMnemonic();
  }

  Future<HDWallet> createAndPersistAccount(
      String password, String mnemonic) async {
    HDWallet wallet = createWallet(mnemonic);
    persistWallet(wallet, password);
    return wallet;
  }

  Future<void> persistWallet(HDWallet wallet, String password) async {
    _walletStorage.storeWallet(wallet, password);
  }
}
