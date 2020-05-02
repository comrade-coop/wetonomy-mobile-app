import 'package:bip39/bip39.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wetonomy/repositories/account_repository.dart';
import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/scrypt_encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'mocks/wallet_storage_mock.dart';

void main() {
  group('AccountRepository', () {
    
    test('Creates a valid mnemonic', () {
      final repository = AccountRepository(WalletCrypto(), WalletStorageMock());

      final String mnemonic = repository.createMnemonic();

      final List<String> words = mnemonic.split(' ');
      final int expectedLen = 12;

      expect(words.length, expectedLen);
    });

    test('Creates wallet given a mnemonic', () {
      final walletUtility = WalletCrypto();
      final repository = AccountRepository(walletUtility, WalletStorageMock());

      final Wallet wallet = repository.createWallet(generateMnemonic());
      expect(wallet != null, true);
    });

    test('Persists wallet', () {
      final walletStorage = WalletStorageMock();

      final repository = AccountRepository(WalletCrypto(), walletStorage);
      final String mnemonic = repository.createMnemonic();
      final Wallet wallet = repository.createWallet(mnemonic);
      final encrypted = ScryptEncryptedWallet.fromWallet(wallet, '');

      bool calledStoreWallet = false;
      when(walletStorage.storeWallet(encrypted)).thenAnswer((_) {
        calledStoreWallet = true;
        return Future.value();
      });

      repository.persistWallet(encrypted);
      expect(calledStoreWallet, true);
    });
  });
}
