import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/wallet.dart';

class AccountRepository {
  final WalletUtility _walletUtil;
  final WalletStorage _walletStorage;

  AccountRepository(this._walletUtil, this._walletStorage)
      : assert(_walletUtil != null),
        assert(_walletStorage != null);

  Wallet createWallet(String mnemonic, String password) {
    if (mnemonic == null) {
      throw ArgumentError.notNull('mnemonic');
    }
    return _walletUtil.createWallet(mnemonic, password);
  }

  String createMnemonic() {
    return _walletUtil.createMnemonic();
  }

  Future<Wallet> createAndPersistAccount(
  String mnemonic, String password) async {
    Wallet wallet = createWallet(mnemonic, password);
    await persistWallet(wallet, password);
    return wallet;
  }

  Future<void> persistWallet(Wallet wallet, String password) async {
    await _walletStorage.storeWallet(wallet);
  }
}
