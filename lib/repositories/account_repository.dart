import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/cosmos_encrypted_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class AccountRepository {
  final WalletUtility _walletUtil;
  final WalletStorage _walletStorage;

  AccountRepository(this._walletUtil, this._walletStorage)
      : assert(_walletUtil != null),
        assert(_walletStorage != null);

  Wallet createWallet(String mnemonic) {
    if (mnemonic == null) {
      throw ArgumentError.notNull('mnemonic');
    }
    return _walletUtil.createWallet(mnemonic);
  }

  String createMnemonic() {
    return _walletUtil.createMnemonic();
  }

  Future<Wallet> createAndPersistAccount(
      String mnemonic, String password) async {
    final Wallet wallet = createWallet(mnemonic);
    final encrypted = CosmosEncryptedWallet.fromWallet(wallet, password);
    await persistWallet(encrypted);
    return wallet;
  }

  Future<void> persistWallet(EncryptedWallet wallet) async {
    await _walletStorage.storeWallet(wallet);
  }
}
