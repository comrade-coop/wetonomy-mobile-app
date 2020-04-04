import 'package:bip39/bip39.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'fakes/fake_encrypted_wallet.dart';

class WalletTestUtils {
  static EncryptedWallet generateEncryptedWallet() {
    final Wallet wallet = CosmosWallet.fromMnemonic(generateMnemonic());
    return FakeEncryptedWallet(wallet);
  }
}
