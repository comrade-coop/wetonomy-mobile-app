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

  Future<HDWallet> createAndPersistAccount(String mnemonic) async {
    HDWallet wallet = createWallet(mnemonic);

    try {
      await persistWallet(wallet);
    } on Exception catch (e) {
      print('Failed saving wallet to storage: ' + e.toString());
    }

    return wallet;
  }

  Future<void> persistWallet(HDWallet wallet) async {

  }
}
