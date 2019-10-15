import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/wallet.dart';

abstract class EncryptedWallet {
  String get address;

  Wallet unlock(String password);

  EncryptedWalletFile toEncryptedWalletFile();
}
