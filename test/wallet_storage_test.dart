import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/wallet/encrypted_wallet.dart';

import 'wallet_test_utils.dart';

class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage {}

void main() {
  group('WalletStorage', () {
    test('storeWallet calls write storage method with correct values', () {
      final storage = FlutterSecureStorageMock();
      final walletStorage = WalletStorage(storage);
      final EncryptedWallet wallet = WalletTestUtils.generateEncryptedWallet();

      walletStorage.storeWallet(wallet);

      final EncryptedWalletFile encryptedFile = wallet.toEncryptedWalletFile();
      final String encoded = jsonEncode(encryptedFile.toJson());
      verify(storage.write(key: wallet.address, value: encoded));
    });

    test('readWallet calls read storage method with correct parameters', () {
      final storage = FlutterSecureStorageMock();
      final walletStorage = WalletStorage(storage);
      final EncryptedWallet wallet = WalletTestUtils.generateEncryptedWallet();

      // Mock will return null so walletStorage should throw as the key is unknown
      expect(
          () => walletStorage.readWallet(wallet.address), throwsArgumentError);

      verify(storage.read(key: wallet.address));
    });

    test('readAllWallets calls readAll storage method', () {
      final storage = FlutterSecureStorageMock();
      final walletStorage = WalletStorage(storage);
      walletStorage.readAllWallets();

      verify(storage.readAll());
    });
  });
}
