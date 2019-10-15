import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wetonomy/repositories/account_repository.dart';
import 'package:wetonomy/services/wallet_utility.dart';
import 'package:wetonomy/wallet/cosmos_encrypted_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'mocks/wallet_storage_mock.dart';

void main() {
  group('AccountRepository', () {
    test('Creates a valid mnemonic', () {
      final repository =
          AccountRepository(WalletUtility(), WalletStorageMock());

      final String mnemonic = repository.createMnemonic();

      final List<String> words = mnemonic.split(' ');
      final int expectedLen = 12;

      expect(words.length, expectedLen);
    });

    test('Creates wallet given a mnemonic', () {
      final walletUtility = WalletUtility();
      final repository = AccountRepository(walletUtility, WalletStorageMock());

      final Wallet wallet =
          repository.createWallet(walletUtility.createMnemonic());
      expect(wallet != null, true);
    });

    test('Persists wallet', () {
      final walletStorage = WalletStorageMock();

      final repository = AccountRepository(WalletUtility(), walletStorage);
      final String mnemonic = repository.createMnemonic();
      final Wallet wallet = repository.createWallet(mnemonic);
      final encrypted = CosmosEncryptedWallet.fromWallet(wallet, '');

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
