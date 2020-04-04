import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

class FakeEncryptedWallet implements EncryptedWallet {
  final Wallet _wallet;

  FakeEncryptedWallet(this._wallet);

  @override
  String get address => _wallet.address;

  @override
  EncryptedWalletFile toEncryptedWalletFile() {
    return EncryptedWalletFile(null, _wallet.address);
  }

  @override
  Wallet unlock(String password) {
    return _wallet;
  }
}
