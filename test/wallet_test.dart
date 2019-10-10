import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
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

//    test('fromJson throws when invalid json is sent', () {
//      final String json = 'Invalid json';
//      expect(() => CosmosWallet.fromJson(json, ''), throwsFormatException);
//    });

//    test('fromJson throws when invalid wallet json is parsed', () {
//      final wallet =
//          CosmosWallet.fromMnemonic(expectedWallet['mnemonic'], Uint8List(0));
//      final Map<String, dynamic> walletJson = json.decode(wallet.toJson());
//
//      print(json.encode(walletJson));
//
//      final emptyJson = '{}';
//      expect(() => CosmosWallet.fromJson(emptyJson, ''), throwsArgumentError);
//
//      final dynamic kdf = walletJson['crypto'].remove('kdf');
//      expect(() => CosmosWallet.fromJson(json.encode(walletJson), ''),
//          throwsArgumentError);
//      walletJson['crypto']['kdf'] = kdf;
//
//      walletJson['crypto'].remove('mac');
//      expect(() => CosmosWallet.fromJson(json.encode(walletJson), ''),
//          throwsArgumentError);
//    });
  });
}
