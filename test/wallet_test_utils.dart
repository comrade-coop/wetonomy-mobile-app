import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'fakes/fake_encrypted_wallet.dart';

class WalletTestUtils {
  static EncryptedWallet generateEncryptedWallet() {
    final walletUtility = WalletUtility();
    final Wallet wallet =
        walletUtility.createWallet(walletUtility.createMnemonic());
    return FakeEncryptedWallet(wallet);
  }
}
