import 'package:bip39/bip39.dart' as Bip39;
import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class AccountRepository {
  final WalletCrypto _walletUtil;
  final WalletStorage _walletStorage;

  AccountRepository(this._walletUtil, this._walletStorage)
      : assert(_walletUtil != null),
        assert(_walletStorage != null);

  Wallet createWallet(String mnemonic) {
    if (mnemonic == null) {
      throw ArgumentError.notNull('mnemonic');
    }
    return CosmosWallet.fromMnemonic(mnemonic);
  }

  String createMnemonic() {
    return Bip39.generateMnemonic();
  }

  Future<Wallet> createAndPersistWallet(
      String mnemonic, String password) async {
    final Wallet wallet = createWallet(mnemonic);
    final encrypted = await _walletUtil.encryptWallet(wallet, password);
    await persistWallet(encrypted);
    return wallet;
  }

  Future<String> persistWallet(EncryptedWallet wallet) async {
    return await _walletStorage.storeWallet(wallet);
  }

  Future<List<EncryptedWallet>> getAllWallets() async {
    return _walletStorage.readAllWallets();
  }

  Future<Wallet> tryUnlockWallet(EncryptedWallet wallet, String password) {
    return _walletUtil.decryptWallet(wallet, password);
  }
}
