import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wetonomy/models/wallet/encrypted_wallet_file.dart';
import 'package:wetonomy/wallet/cosmos_encrypted_wallet.dart';
import 'package:wetonomy/wallet/cosmos_wallet.dart';
import 'package:wetonomy/wallet/wallet.dart';

import 'wallet_test_data.dart';

void main() {
  group('Wallet', () {
    test('Creates correct private key', () {
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      expect(wallet.privateKey, expectedWallet['privateKey']);
    });

    test('Creates correct public key', () {
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      expect(wallet.publicKey, expectedWallet['publicKey']);
    });

    test('Signes messages correctly', () {
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      final Uint8List signature = wallet.sign('Hello World!');
      expect(signature, expectedWallet['signature']);
    });

    test('Creates a wallet from base58 correctly', () {
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);

      String base58 = wallet.toBase58();
      final base58Wallet = CosmosWallet.fromBase58(base58);

      expect(base58Wallet.privateKey, wallet.privateKey);
    });

    test('fromEncryptedWallet works correctly', () {
      final String password = 'testpass';
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      final encrypted = CosmosEncryptedWallet.fromWallet(wallet, password);

      final Wallet unlocked = encrypted.unlock(password);

      expect(unlocked.privateKey, wallet.privateKey);
    });

    test('fromEncryptedWallet throws when invalid password is used', () {
      final String password = 'testpass';
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      final encrypted = CosmosEncryptedWallet.fromWallet(wallet, password);

      expect(() => encrypted.unlock('wrongpass'), throwsArgumentError);
    });

    test('Wallet serialisation works correctly', () {
      final String password = 'password';
      final wallet = CosmosWallet.fromMnemonic(expectedWallet['mnemonic']);
      final encryptedWallet =
          CosmosEncryptedWallet.fromWallet(wallet, password);
      final walletFile = encryptedWallet.toEncryptedWalletFile();
      final Map<String, dynamic> walletJson = walletFile.toJson();

      final deserialised = EncryptedWalletFile.fromJson(walletJson);
      final deserialisedEncrypted =
          CosmosEncryptedWallet.fromEncryptedWalletFile(deserialised);

      final unlocked = deserialisedEncrypted.unlock(password);
      expect(unlocked.privateKey, wallet.privateKey);
    });
  });
}
